class LoginResponse {
  int? statusCode;
  UserLoginData? data;
  String? message;

  LoginResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? UserLoginData.fromMap(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toMap();
    }
    data['message'] = message;
    return data;
  }
}

class UserLoginData {
  String? userMobile;
  String? userToken;
  String? userType;
  String? userId;
  String? userStatus;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? countryCode;
  String? zipCode;
  String? province;
  String? profileImg;
  String? description;
  String? deviceToken;
  String? isSubscribed;
  int? userOtp;

  UserLoginData({
    this.userMobile,
    this.userToken,
    this.userType,
    this.userId,
    this.userStatus,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.countryCode,
    this.zipCode,
    this.province,
    this.profileImg,
    this.description,
    this.deviceToken,
    this.isSubscribed,
    this.userOtp,
  });

  UserLoginData.fromMap(Map<String, dynamic> json) {
    userMobile = json['user_mobile'];
    userToken = json['user_token'];
    userType = json['user_type'];
    userId = json['user_id'];
    userStatus = json['user_status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    countryCode = json['country_code'];
    zipCode = json['zip_code'];
    province = json['province'];
    profileImg = json['profile_img'];
    description = json['description'];
    deviceToken = json['device_token'];
    isSubscribed = json['is_subscribed'];
    userOtp = json['user_otp'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_mobile'] = userMobile;
    data['user_token'] = userToken;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['user_status'] = userStatus;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['city'] = city;
    data['country_code'] = countryCode;
    data['zip_code'] = zipCode;
    data['province'] = province;
    data['profile_img'] = profileImg;
    data['description'] = description;
    data['device_token'] = deviceToken;
    data['is_subscribed'] = isSubscribed;
    data['user_otp'] = userOtp;
    return data;
  }
}
