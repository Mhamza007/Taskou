import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class TrackingServiceApi {
  TrackingServiceApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.userBaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<TrackingResponse?> getTrackingData({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.get(
        'getChild',
      );

      if (response != null) {
        return TrackingResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AddDeleteChildResponse?> addChild({
    required String userToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'addChild',
        data: data,
      );
      if (response != null) {
        return AddDeleteChildResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AddDeleteChildResponse?> deleteChild({
    required String userToken,
    required String childId,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'deleteChild',
        data: {
          'child_id': childId,
        },
      );
      if (response != null) {
        return AddDeleteChildResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ChildModeResponse?> childMode({
    required Map<String, dynamic> data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': Constants.testDeviceToken,
      });
      var response = await dioBase?.post(
        'verifyCode',
        data: data,
      );
      if (response != null) {
        return ChildModeResponse.fromJson(response);
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
