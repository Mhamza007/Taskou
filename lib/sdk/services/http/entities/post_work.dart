import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class PostWorkApi {
  PostWorkApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.userBaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<PostWorkResponse?> postWork({
    required String userToken,
    required Map data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'Workpost',
        data: data,
      );

      if (response != null) {
        return PostWorkResponse.fromJson(response);
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
