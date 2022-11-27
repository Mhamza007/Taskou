import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../db/db.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../sdk/sdk.dart';
import '../../../../../../app.dart';

part 'find_serviceman_state.dart';

class FindServicemanCubit extends Cubit<FindServicemanState> {
  FindServicemanCubit(
    this.context,
  ) : super(const FindServicemanState()) {
    _categoriesApi = CategoriesApi();

    searchController = TextEditingController();

    searchController.addListener(() {
      emit(
        state.copyWith(
          isSearching: searchController.text.isNotEmpty,
        ),
      );

      filter();
    });

    getCategories();
  }

  final BuildContext context;
  late final CategoriesApi _categoriesApi;
  late final TextEditingController searchController;

  Future<void> getCategories() async {
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );
      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var response = await _categoriesApi.getCategories();

        if (response?.statusCode == 200 && response?.data != null) {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.success,
              categories: response?.data,
            ),
          );
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: response?.message ?? Res.string.apiErrorMessage,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  void filter() {
    if (state.categories != null && state.categories!.isNotEmpty) {
      var query = searchController.text;
      var searchList = <CategoriesResponseData>[];
      for (var element in state.categories!) {
        if (element.categoryName?.toLowerCase().contains(query.toLowerCase()) ==
            true) {
          searchList.add(element);
        } else {
          searchList.remove(element);
        }
      }
      emit(
        state.copyWith(
          filterList: searchList,
        ),
      );
    }
  }

  void onItemTap(CategoriesResponseData item) {
    debugPrint(item.toString());
    if (item.catId != null) {
      if (item.catId == '19') {
        openSpeedometer();
      } else {
        getSubCategories(
          categoryId: item.catId!,
          categoryName: item.categoryName!,
        );
      }
    } else {
      // Error
    }
  }

  void openSpeedometer() {
    Navigator.pushNamed(
      context,
      Routes.tracking,
    );
  }

  Future<void> getSubCategories({
    required String categoryId,
    required String categoryName,
  }) async {
    Map<String, dynamic> categoryData = {
      'cat_id': categoryId,
    };
    try {
      emit(
        state.copyWith(
          subLoading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var response = await _categoriesApi.getSubCategories(
          categoryData: categoryData,
        );

        if (response?.statusCode == 200 && response?.data != null) {
          if (response!.data!.isNotEmpty) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(
              context,
              Routes.subCategory,
              arguments: {
                'title': categoryName,
                'response': response.toJson(),
              },
            );
          } else {
            // ignore: use_build_context_synchronously
            context.read<DashboardCubit>().showBottomSheetPopup(
              browseService: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.browseService,
                  arguments: categoryData,
                );
              },
              postWork: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.postWork,
                  arguments: categoryData,
                );
              },
            );
          }
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: response?.message ?? Res.string.apiErrorMessage,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          subLoading: false,
        ),
      );
    }
  }
}
