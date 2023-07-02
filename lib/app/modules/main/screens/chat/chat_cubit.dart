import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../app.dart';
import '../../../../models/models.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    this.context, {
    this.data,
  }) : super(const ChatState()) {
    _userStorage = UserStorage();
    _chatService = ChatService();
    messagesScrollController = ScrollController();
    messageController = TextEditingController();
    uuid = const Uuid();
    messageController.addListener(() {
      emit(
        state.copyWith(
          isTyping: messageController.text.isNotEmpty,
        ),
      );
    });

    getChatUsers();
    messages = [];
    getMessages();
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late ChatService _chatService;
  late ScrollController messagesScrollController;
  late TextEditingController messageController;
  late List<Map> messages;
  final Map? data;
  String? senderId;
  String? receiverId;
  late Uuid uuid;

  void back() => Navigator.pop(context);

  void getChatUsers() {
    senderId = _userStorage.getUserId();
    receiverId = data?['receiver_id'];
    emit(
      state.copyWith(
        senderId: senderId,
        receiverId: receiverId,
        receiverName: data?['receiver_name'],
      ),
    );
  }

  Stream<QuerySnapshot>? getMessages() {
    if (senderId != null && receiverId != null) {
      return _chatService.fetchMessagesBetween(
        userId: senderId!,
        receiverId: receiverId!,
      );
    } else {
      return null;
    }
  }

  Future sendMessage() async {
    try {
      emit(
        state.copyWith(
          sending: true,
        ),
      );
      var senderName =
          '${_userStorage.getUserFirstName()} ${_userStorage.getUserLastName()}';

      var message = Message(
        uid: uuid.v1(),
        senderId: senderId,
        receiverId: receiverId,
        type: 'text',
        message: messageController.text,
        time: DateTime.now().millisecondsSinceEpoch,
        status: 'sent',
        fcmToken: '',
        senderName: senderName,
      );

      messageController.clear();
      await _chatService.addMessageToDb(message.toMap());

      messagesScrollController.animateTo(
        messagesScrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 250),
        curve: Curves.easeOut,
      );
    } catch (e) {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.errorSendingMessage,
      );
    } finally {
      emit(
        state.copyWith(
          sending: false,
        ),
      );
    }
  }

  // sendMessage() {
  //   var dateTime = DateTime.now();
  //   var dateTimeString = DateFormat('dd MMM, hh:mm a').format(dateTime);
  //   messages.add(
  //     {
  //       'message': messageController.text,
  //       'dateTime': dateTimeString,
  //     },
  //   );
  //   emit(
  //     state.copyWith(
  //       messages: messages,
  //     ),
  //   );
  //   messageController.clear();
  // }

  @override
  Future<void> close() {
    messages.clear();
    return super.close();
  }
}
