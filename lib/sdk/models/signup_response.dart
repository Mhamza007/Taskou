class SignupResponse {
  SignupResponseData? data;
  String? message;
  int? statusCode;

  SignupResponse({this.data, this.message, this.statusCode});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? SignupResponseData.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class SignupResponseData {
  String? city;
  String? email;
  String? firstName;
  String? lastName;
  String? province;
  int? userId;
  String? userMobile;
  int? userOtp;
  String? userToken;
  String? zipCode;

  SignupResponseData(
      {this.city,
      this.email,
      this.firstName,
      this.lastName,
      this.province,
      this.userId,
      this.userMobile,
      this.userOtp,
      this.userToken,
      this.zipCode});

  SignupResponseData.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    province = json['province'];
    userId = json['user_id'];
    userMobile = json['user_mobile'];
    userOtp = json['user_otp'];
    userToken = json['user_token'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['province'] = province;
    data['user_id'] = userId;
    data['user_mobile'] = userMobile;
    data['user_otp'] = userOtp;
    data['user_token'] = userToken;
    data['zip_code'] = zipCode;
    return data;
  }
}
