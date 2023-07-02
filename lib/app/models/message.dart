enum MessageStatus {
  sent,
  delivered,
  seen,
}

enum MessageType {
  text,
  image,
  file,
}

class Message {
  String? uid;
  String? senderId;
  String? receiverId;
  String? type;
  String? message;
  int? time;
  String? status;
  String? photoUrl;
  String? fileUrl;
  String? localMediaPath;
  String? fcmToken;
  String? senderName;

  Message({
    required this.uid,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.message,
    required this.time,
    required this.status,
    this.photoUrl,
    this.fileUrl,
    this.localMediaPath,
    this.fcmToken,
    this.senderName,
  });

  Message.fromFromMap(Map<String, dynamic> json) {
    uid = json['uid'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    type = json['type'];
    message = json['message'];
    time = json['time'];
    status = json['status'];
    photoUrl = json['photo_url'];
    fileUrl = json['file_url'];
    localMediaPath = json['local_media_path'];
    fcmToken = json['fcmToken'];
    senderName = json['senderName'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['type'] = type;
    data['message'] = message;
    data['time'] = time;
    data['status'] = status;
    data['photo_url'] = photoUrl;
    data['file_url'] = fileUrl;
    data['local_media_path'] = localMediaPath;
    data['fcmToken'] = fcmToken;
    data['senderName'] = senderName;
    return data;
  }

  Message copyWith({
    String? uid,
    String? senderId,
    String? receiverId,
    String? type,
    String? message,
    int? time,
    String? status,
    String? photoUrl,
    String? fileUrl,
    String? localMediaPath,
    String? fcmToken,
    String? senderName,
  }) {
    return Message(
      uid: uid ?? this.uid,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      message: message ?? this.message,
      time: time ?? this.time,
      status: status ?? this.status,
      photoUrl: photoUrl ?? this.photoUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      localMediaPath: localMediaPath ?? this.localMediaPath,
      fcmToken: fcmToken ?? this.fcmToken,
      senderName: senderName ?? this.senderName,
    );
  }
}
