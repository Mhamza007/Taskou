class ScheduleBookingsResponse {
  int? statusCode;
  List<ScheduleBookingsData>? data;
  String? message;

  ScheduleBookingsResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  ScheduleBookingsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <ScheduleBookingsData>[];
      json['data'].forEach((v) {
        data!.add(ScheduleBookingsData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ScheduleBookingsData {
  String? bookingId;
  String? userId;
  String? handymanId;
  String? handymanCity;
  String? bookingType;
  dynamic amount;
  String? message;
  String? bookingStatus;
  dynamic category;
  dynamic subcategory;
  dynamic subSubCategory;
  dynamic subSubSubCategory;
  String? address;
  String? userLat;
  String? userLong;
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleStatus;
  dynamic handymanLat;
  dynamic handymanLong;
  String? pickup;
  String? createdOn;
  String? firstName;
  String? lastName;
  String? price;

  ScheduleBookingsData({
    this.bookingId,
    this.userId,
    this.handymanId,
    this.handymanCity,
    this.bookingType,
    this.amount,
    this.message,
    this.bookingStatus,
    this.category,
    this.subcategory,
    this.subSubCategory,
    this.subSubSubCategory,
    this.address,
    this.userLat,
    this.userLong,
    this.scheduleDate,
    this.scheduleTime,
    this.scheduleStatus,
    this.handymanLat,
    this.handymanLong,
    this.pickup,
    this.createdOn,
    this.firstName,
    this.lastName,
    this.price,
  });

  ScheduleBookingsData.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    userId = json['user_id'];
    handymanId = json['handyman_id'];
    handymanCity = json['handyman_city'];
    bookingType = json['booking_type'];
    amount = json['amount'];
    message = json['message'];
    bookingStatus = json['booking_status'];
    category = json['category'];
    subcategory = json['subcategory'];
    subSubCategory = json['sub_sub_category'];
    subSubSubCategory = json['sub_sub_sub_category'];
    address = json['address'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    scheduleDate = json['schedule_date'];
    scheduleTime = json['schedule_time'];
    scheduleStatus = json['schedule_status'];
    handymanLat = json['handyman_lat'];
    handymanLong = json['handyman_long'];
    pickup = json['pickup'];
    createdOn = json['created_on'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['user_id'] = userId;
    data['handyman_id'] = handymanId;
    data['handyman_city'] = handymanCity;
    data['booking_type'] = bookingType;
    data['amount'] = amount;
    data['message'] = message;
    data['booking_status'] = bookingStatus;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['sub_sub_category'] = subSubCategory;
    data['sub_sub_sub_category'] = subSubSubCategory;
    data['address'] = address;
    data['user_lat'] = userLat;
    data['user_long'] = userLong;
    data['schedule_date'] = scheduleDate;
    data['schedule_time'] = scheduleTime;
    data['schedule_status'] = scheduleStatus;
    data['handyman_lat'] = handymanLat;
    data['handyman_long'] = handymanLong;
    data['pickup'] = pickup;
    data['created_on'] = createdOn;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['price'] = price;
    return data;
  }
}
