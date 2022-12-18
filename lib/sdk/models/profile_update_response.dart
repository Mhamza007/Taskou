class ProfileUpdateResponse {
  int? statusCode;
  ProfileUpdateResponseData? data;
  String? message;

  ProfileUpdateResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? ProfileUpdateResponseData.fromJson(json['data'])
        : null;
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

class ProfileUpdateResponseData {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? province;
  String? zipCode;
  String? userMobile;
  String? countryCode;
  String? profileImg;
  String? userToken;

  ProfileUpdateResponseData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.province,
    this.zipCode,
    this.userMobile,
    this.countryCode,
    this.profileImg,
    this.userToken,
  });

  ProfileUpdateResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    province = json['province'];
    zipCode = json['zip_code'];
    userMobile = json['user_mobile'];
    countryCode = json['country_code'];
    profileImg = json['profile_img'];
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['city'] = city;
    data['province'] = province;
    data['zip_code'] = zipCode;
    data['user_mobile'] = userMobile;
    data['country_code'] = countryCode;
    data['profile_img'] = profileImg;
    data['user_token'] = userToken;
    return data;
  }
}
