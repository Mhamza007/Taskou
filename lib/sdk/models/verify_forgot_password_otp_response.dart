class VerifyForgotPasswordOTPResponse {
  int? statusCode;
  VerifyForgotPasswordOTPResponseData? data;
  String? message;

  VerifyForgotPasswordOTPResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  VerifyForgotPasswordOTPResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? VerifyForgotPasswordOTPResponseData.fromJson(json['data'])
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

class VerifyForgotPasswordOTPResponseData {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? province;
  String? zipCode;
  String? userMobile;
  String? userToken;
  String? isUpdated;

  VerifyForgotPasswordOTPResponseData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.province,
    this.zipCode,
    this.userMobile,
    this.userToken,
    this.isUpdated,
  });

  VerifyForgotPasswordOTPResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    province = json['province'];
    zipCode = json['zip_code'];
    userMobile = json['user_mobile'];
    userToken = json['user_token'];
    isUpdated = json['is_updated'];
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
    data['user_token'] = userToken;
    data['is_updated'] = isUpdated;
    return data;
  }
}
