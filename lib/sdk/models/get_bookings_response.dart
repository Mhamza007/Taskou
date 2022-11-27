class GetBookingsResponse {
  int? statusCode;
  List<GetBookingsData>? data;
  String? message;

  GetBookingsResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  GetBookingsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <GetBookingsData>[];
      json['data'].forEach((v) {
        data!.add(GetBookingsData.fromJson(v));
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

class GetBookingsData {
  String? bookingId;
  String? userId;
  String? handymanId;
  String? handymanCity;
  String? amount;
  String? message;
  String? bookingStatus;
  String? category;
  String? subcategory;
  String? address;
  String? userLat;
  String? userLong;
  String? createdOn;
  String? userMobile;
  String? email;
  String? province;
  String? city;
  String? userStatus;
  String? profileImg;
  String? firstName;
  String? lastName;
  String? price;
  String? countryCode;
  String? description;

  GetBookingsData({
    this.bookingId,
    this.userId,
    this.handymanId,
    this.handymanCity,
    this.amount,
    this.message,
    this.bookingStatus,
    this.category,
    this.subcategory,
    this.address,
    this.userLat,
    this.userLong,
    this.createdOn,
    this.userMobile,
    this.email,
    this.province,
    this.city,
    this.userStatus,
    this.profileImg,
    this.firstName,
    this.lastName,
    this.price,
    this.countryCode,
    this.description,
  });

  GetBookingsData.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    userId = json['user_id'];
    handymanId = json['handyman_id'];
    handymanCity = json['handyman_city'];
    amount = json['amount'];
    message = json['message'];
    bookingStatus = json['booking_status'];
    category = json['category'];
    subcategory = json['subcategory'];
    address = json['address'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    createdOn = json['created_on'];
    userMobile = json['user_mobile'];
    email = json['email'];
    province = json['province'];
    city = json['city'];
    userStatus = json['user_status'];
    profileImg = json['profile_img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    price = json['price'];
    countryCode = json['country_code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['user_id'] = userId;
    data['handyman_id'] = handymanId;
    data['handyman_city'] = handymanCity;
    data['amount'] = amount;
    data['message'] = message;
    data['booking_status'] = bookingStatus;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['address'] = address;
    data['user_lat'] = userLat;
    data['user_long'] = userLong;
    data['created_on'] = createdOn;
    data['user_mobile'] = userMobile;
    data['email'] = email;
    data['province'] = province;
    data['city'] = city;
    data['user_status'] = userStatus;
    data['profile_img'] = profileImg;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['price'] = price;
    data['country_code'] = countryCode;
    data['description'] = description;
    return data;
  }
}
