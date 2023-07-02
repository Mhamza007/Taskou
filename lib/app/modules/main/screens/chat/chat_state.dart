// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.isTyping = false,
    this.senderId,
    this.receiverId,
    this.receiverName,
    this.sending = false,
  });

  final bool isTyping;
  final String? senderId;
  final String? receiverId;
  final String? receiverName;
  final bool sending;

  @override
  List<Object?> get props => [
        isTyping,
        senderId,
        receiverId,
        receiverName,
        sending,
      ];

  ChatState copyWith({
    bool? isTyping,
    String? senderId,
    String? receiverId,
    String? receiverName,
    bool? sending,
  }) {
    return ChatState(
      isTyping: isTyping ?? this.isTyping,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      sending: sending ?? this.sending,
    );
  }
}
