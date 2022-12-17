class BookHandymanResponse {
  int? statusCode;
  Data? data;
  String? message;

  BookHandymanResponse({this.statusCode, this.data, this.message});

  BookHandymanResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? notificationBy;
  String? notificationTo;
  String? notificationMessage;
  String? notificationImg;
  String? notificationType;
  int? createdOn;
  String? userName;
  String? userLat;
  String? userLong;
  String? address;
  int? bookingId;
  String? message;

  Data(
      {this.notificationBy,
      this.notificationTo,
      this.notificationMessage,
      this.notificationImg,
      this.notificationType,
      this.createdOn,
      this.userName,
      this.userLat,
      this.userLong,
      this.address,
      this.bookingId,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    notificationBy = json['notification_by'];
    notificationTo = json['notification_to'];
    notificationMessage = json['notification_message'];
    notificationImg = json['notification_img'];
    notificationType = json['notification_type'];
    createdOn = json['created_on'];
    userName = json['user_name'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    address = json['address'];
    bookingId = json['Booking_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_by'] = notificationBy;
    data['notification_to'] = notificationTo;
    data['notification_message'] = notificationMessage;
    data['notification_img'] = notificationImg;
    data['notification_type'] = notificationType;
    data['created_on'] = createdOn;
    data['user_name'] = userName;
    data['user_lat'] = userLat;
    data['user_long'] = userLong;
    data['address'] = address;
    data['Booking_id'] = bookingId;
    data['message'] = message;
    return data;
  }
}
