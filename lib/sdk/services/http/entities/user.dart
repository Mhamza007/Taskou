import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class UserApi {
  UserApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.userBaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<LoginResponse?> loginUser({
    required Map<String, dynamic> userData,
  }) async {
    try {
      var response = await dioBase?.post(
        'user_login',
        data: userData,
      );
      if (response != null) {
        return LoginResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SignupResponse?> signUpUser({
    required Map<String, dynamic> userData,
  }) async {
    try {
      var formData = FormData.fromMap(userData);
      var response = await dioBase?.post(
        'user_signup',
        data: formData,
      );
      if (response != null) {
        return SignupResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse?> verifyOtp({
    required Map<String, dynamic> userData,
  }) async {
    try {
      var response = await dioBase?.post(
        'verify_mobile',
        data: userData,
      );
      if (response != null) {
        return LoginResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ChangePasswordResponse> changePassword({
    required String userToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'change_password',
        data: data,
      );
      if (response != null) {
        return ChangePasswordResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileUpdateResponse> updateProfile({
    required String userToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'user_update',
        data: data,
      );
      if (response != null) {
        return ProfileUpdateResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordResponse?> forgotPassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dioBase?.post(
        'forget_pass',
        data: data,
      );

      if (response != null) {
        return ForgotPasswordResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyForgotPasswordOTPResponse?> verifyForgotPasswordOTPResponse({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dioBase?.post(
        'verify_forget_pass_otp',
        data: data,
      );

      if (response != null) {
        return VerifyForgotPasswordOTPResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> updatePassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dioBase?.post(
        'update_password',
        data: data,
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
