class ForgotPasswordResponse {
  int? statusCode;
  ForgotPasswordResponseData? data;
  String? message;

  ForgotPasswordResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? ForgotPasswordResponseData.fromJson(json['data'])
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

class ForgotPasswordResponseData {
  String? userMobile;
  String? userOtp;
  String? userId;

  ForgotPasswordResponseData({
    this.userMobile,
    this.userOtp,
    this.userId,
  });

  ForgotPasswordResponseData.fromJson(Map<String, dynamic> json) {
    userMobile = json['user_mobile'];
    userOtp = json['user_otp'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_mobile'] = userMobile;
    data['user_otp'] = userOtp;
    data['user_id'] = userId;
    return data;
  }
}
