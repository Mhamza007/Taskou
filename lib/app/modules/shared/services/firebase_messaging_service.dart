// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    name: 'Taskou',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Handling a background message ${message.messageId}');
}

_initFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  BehaviorSubject<RemoteMessage> messageStreamController =
      BehaviorSubject<RemoteMessage>();

  var token = await messaging.getToken();

  debugPrint('User granted permission: ${settings.authorizationStatus}');

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {}

  var channel = const AndroidNotificationChannel(
    'booking', // id
    'Booking Service', // name
    description:
        'To send notifications when chat message is received', // description
    importance: Importance.high,
    enableVibration: true,
  );

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Handling a foreground message: ${message.messageId}');
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');
    debugPrint('Message notification: ${message.notification?.body}');

    messageStreamController.sink.add(message);
  });

  messageStreamController.listen((message) {
    RemoteNotification? notification = message.notification;
    if (Platform.isAndroid) {
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: null,
            ),
          ),
        );
      }
    } else if (Platform.isIOS) {
      AppleNotification? apple = message.notification?.apple;
      if (notification != null && apple != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            iOS: DarwinNotificationDetails(),
          ),
        );
      }
    }
    Map<String, dynamic>? messageMap;
    if (message.notification != null) {
      messageMap = {
        'title': message.notification?.title,
        'body': message.notification?.body,
        'data': message.data,
      };
    } else {
      messageMap = message.data;
    }
    debugPrint('messageMap data $messageMap');
  });
}

Future<void> initializeFirebaseMessagingService() async {
  try {
    _initFirebaseMessaging();

    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
  } catch (_) {}
}

Future<void> sendPushNotification({
  required String id,
  required String title,
  required String body,
  required String token,
}) async {
  try {
    var response = await Dio().post(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAj4mrt7Y:APA91bH0MJt8RRJyAzIY16zU-XTmZq7Muu_Ct2SACyYuzGMtncxBZV2WENlAf1gbJviSZda-S4uLnyX9GLc16xGA5K3c-XPZ90ZtaP3bpwEnnWHIqL6ubK-uizND_ksH-dLFmn6rvlp2',
        },
      ),
      data: {
        'notification': <String, dynamic>{
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done'
        },
        "to": token,
      },
    );
    debugPrint('response $response');
  } catch (e) {
    debugPrint('exception $e');
  }
}
