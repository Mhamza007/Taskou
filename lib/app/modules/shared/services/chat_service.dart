import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../../models/models.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _chatCollection = _firestore.collection('chat');

  final CollectionReference _userCollection = _firestore.collection('user');

  Future<void> addMessageToDb(
    dynamic message,
  ) async {
    await addToContacts(
      senderId: message['sender_id'],
      receiverId: message['receiver_id'],
      fcmToken: message['fcmToken'] ?? '',
    );

    await _chatCollection
        .doc(message['sender_id'])
        .collection(message['receiver_id'])
        .doc(message['uid'])
        .set(message);

    await _chatCollection
        .doc(message['receiver_id'])
        .collection(message['sender_id'])
        .doc(message['uid'])
        .set(message);

    sendPushMessage(
      message['message'] ?? '',
      message['senderName'] ?? '',
      message['fcmToken'] ?? '',
    );
  }

  void sendPushMessage(
    String body,
    String title,
    String token,
  ) async {
    try {
      await Dio().post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAnqt3R_M:APA91bEJXZxdDMVhXeFI7bDoJ0Q4dZQaPEiZ_Lsb7fIuxcEGZkMEx3IgPVcfYX2HIFWI-oHJHWxYKj83JjopJBPQWWcwsLvgmwI60TuHIv7zyTZo2qx0d6JK56ABubw_p31smmhQwWrV',
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
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  Future<void> updateMessage({
    required String? currentUserId,
    required String? otherUserId,
    required Message message,
  }) async {
    await _chatCollection
        .doc(currentUserId)
        .collection(otherUserId!)
        .doc(message.uid)
        .update(message.toMap());
  }

  Future addToContacts({
    required String senderId,
    required String receiverId,
    required String fcmToken,
  }) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    await addToSenderContacts(
      senderId,
      receiverId,
      fcmToken,
      currentTime,
    );
    await addToReceiverContacts(
      senderId,
      receiverId,
      fcmToken,
      currentTime,
    );
  }

  DocumentReference getContactsDocument({
    required String of,
    required String forContact,
  }) =>
      _userCollection.doc(of).collection('contacts').doc(forContact);

  Future<void> addToSenderContacts(
    String senderId,
    String receiverId,
    String fcmToken,
    int currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (senderSnapshot.exists) return;

    Contact contact = Contact(
      contactId: receiverId,
      dateTime: currentTime,
      fcmToken: fcmToken,
    );

    await getContactsDocument(
      of: senderId,
      forContact: receiverId,
    ).set(
      contact.toMap(),
    );
  }

  Future<void> addToReceiverContacts(
    String senderId,
    String receiverId,
    String fcmToken,
    int currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (receiverSnapshot.exists) return;

    Contact contact = Contact(
      contactId: senderId,
      dateTime: currentTime,
      fcmToken: fcmToken,
    );

    await getContactsDocument(of: receiverId, forContact: senderId)
        .set(contact.toMap());
  }

  Stream<QuerySnapshot> fetchChats({
    required String userId,
  }) =>
      _userCollection.doc(userId).collection('contacts').snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    required String senderId,
    required String receiverId,
  }) =>
      _chatCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy('time')
          .snapshots();

  Stream<QuerySnapshot> fetchMessagesBetween({
    required String userId,
    required String receiverId,
  }) =>
      _chatCollection
          .doc(userId)
          .collection(receiverId)
          .orderBy('time')
          .snapshots();
}
