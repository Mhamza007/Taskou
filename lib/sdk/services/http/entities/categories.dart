import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class CategoriesApi {
  CategoriesApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.handymanbaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<CategoriesResponse?> getCategories() async {
    try {
      var response = await dioBase?.get(
        'get_category',
      );

      if (response != null) {
        return CategoriesResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SubCategoriesResponse?> getSubCategories({
    required Map<String, dynamic> categoryData,
  }) async {
    try {
      var response = await dioBase?.post(
        'get_sub_category',
        data: categoryData,
      );

      if (response != null) {
        return SubCategoriesResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Sub2CategoriesResponse?> getSub2Categories({
    required Map<String, dynamic> subCategoryData,
  }) async {
    try {
      var response = await dioBase?.post(
        'get_sub2_category',
        data: subCategoryData,
      );

      if (response != null) {
        return Sub2CategoriesResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Sub3CategoriesResponse?> getSub3Categories({
    required Map<String, dynamic> sub2CategoryData,
  }) async {
    try {
      var response = await dioBase?.post(
        'get_sub3_category',
        data: sub2CategoryData,
      );

      if (response != null) {
        return Sub3CategoriesResponse.fromJson(response);
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
