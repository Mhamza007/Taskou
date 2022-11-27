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
        'user_token': Constants.userToken,
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
}
