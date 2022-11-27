import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class BrowseServiceApi {
  BrowseServiceApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.userBaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<BrowseServiceResponse?> getBrowseService({
    required String userToken,
    required Map data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'getHandyman',
        data: data,
      );

      if (response != null) {
        return BrowseServiceResponse.fromJson(response);
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
