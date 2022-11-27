import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit(
    this.context,
    this.title,
    this.subCategoryResponse,
  ) : super(const SubCategoryState()) {
    pageController = PageController(
      initialPage: state.page,
    );
    _categoriesApi = CategoriesApi();

    getTitle();
    getSubCategoriesList();
  }

  final BuildContext context;
  final String title;
  final dynamic subCategoryResponse;
  late SubCategoriesResponse? subCategoriesResponse;
  late PageController pageController;
  late final CategoriesApi _categoriesApi;

  getTitle() {
    emit(
      state.copyWith(
        title: title,
      ),
    );
  }

  getSubCategoriesList() {
    subCategoriesResponse = SubCategoriesResponse?.fromJson(
      subCategoryResponse,
    );
    debugPrint('$subCategoriesResponse');
    emit(
      state.copyWith(
        subCategoriesList: subCategoriesResponse?.data,
      ),
    );
  }

  Future<void> onSubCategoryClicked(
    SubCategoriesData subCategoriesData,
  ) async {
    debugPrint('${subCategoriesData.toJson()}');
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        Sub2CategoriesResponse? response =
            await _categoriesApi.getSub2Categories(
          subCategoryData: {
            'cat_id': '${subCategoriesData.categoryId}',
            'sub_id': '${subCategoriesData.subCatId}',
          },
        );
        if (response?.statusCode == 200 && response?.data != null) {
          debugPrint('${response?.data}');
          if (response!.data!.isNotEmpty) {
            emit(
              state.copyWith(
                sub2CategoriesList: response.data,
                sub2CategoryName: subCategoriesData.subCategory,
              ),
            );
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          } else {
            // ignore: use_build_context_synchronously
            context.read<DashboardCubit>().showBottomSheetPopup(
              browseService: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.browseService,
                  arguments: {
                    'cat_id': '${subCategoriesData.categoryId}',
                    'sub1_id': '${subCategoriesData.subCatId}',
                  },
                );
              },
              postWork: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.postWork,
                  arguments: {
                    'cat_id': '${subCategoriesData.categoryId}',
                    'sub1_id': '${subCategoriesData.subCatId}',
                  },
                );
              },
            );
          }
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

  Future<void> onSub2CategoryClicked(
    Sub2CategoriesData sub2CategoriesData,
  ) async {
    debugPrint('${sub2CategoriesData.toJson()}');

    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        Sub3CategoriesResponse? response =
            await _categoriesApi.getSub3Categories(
          sub2CategoryData: {
            'cat_id': '${sub2CategoriesData.catId}',
            'sub_id': '${sub2CategoriesData.subcatId}',
            'sub2_id': '${sub2CategoriesData.id}',
          },
        );
        if (response?.statusCode == 200 && response?.data != null) {
          if (response!.data!.isNotEmpty) {
            emit(
              state.copyWith(
                sub3CategoriesList: response.data,
                sub3CategoryName: sub2CategoriesData.subSubCatName,
              ),
            );
            pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          } else {
            // ignore: use_build_context_synchronously
            context.read<DashboardCubit>().showBottomSheetPopup(
              browseService: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.browseService,
                  arguments: {
                    'cat_id': '${sub2CategoriesData.catId}',
                    'sub1_id': '${sub2CategoriesData.subcatId}',
                    'sub2_id': '${sub2CategoriesData.id}',
                  },
                );
              },
              postWork: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.postWork,
                  arguments: {
                    'cat_id': '${sub2CategoriesData.catId}',
                    'sub1_id': '${sub2CategoriesData.subcatId}',
                    'sub2_id': '${sub2CategoriesData.id}',
                  },
                );
              },
            );
          }
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

  Future<void> onSub3CategoryClicked(
    Sub3CategoriesData sub3CategoriesData,
  ) async {
    debugPrint('${sub3CategoriesData.toJson()}');

    // ignore: use_build_context_synchronously
    context.read<DashboardCubit>().showBottomSheetPopup(
      browseService: () {
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          Routes.browseService,
          arguments: {
            'cat_id': '${sub3CategoriesData.catId}',
            'sub1_id': '${sub3CategoriesData.subId}',
            'sub2_id': '${sub3CategoriesData.subSubId}',
            'sub3_id': '${sub3CategoriesData.id}',
          },
        );
      },
      postWork: () {
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          Routes.postWork,
          arguments: {
            'cat_id': '${sub3CategoriesData.catId}',
            'sub1_id': '${sub3CategoriesData.subId}',
            'sub2_id': '${sub3CategoriesData.subSubId}',
            'sub3_id': '${sub3CategoriesData.id}',
          },
        );
      },
    );
  }

  void onPageChanged(int page) {
    emit(
      state.copyWith(
        page: page,
      ),
    );
    switch (page) {
      case 0:
        emit(
          state.copyWith(
            sub2CategoryName: '',
            sub3CategoryName: '',
          ),
        );
        break;
      case 1:
        emit(
          state.copyWith(
            sub3CategoryName: '',
          ),
        );
        break;
      case 2:
        break;
      default:
        break;
    }

    if (state.sub3CategoryName.isNotEmpty) {
      emit(
        state.copyWith(
          title:
              '$title > ${state.sub2CategoryName} > ${state.sub3CategoryName}',
        ),
      );
    } else if (state.sub2CategoryName.isNotEmpty) {
      emit(
        state.copyWith(
          title: '$title > ${state.sub2CategoryName}',
        ),
      );
    } else {
      emit(
        state.copyWith(
          title: title,
        ),
      );
    }
  }

  void back() {
    if (state.page > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    } else {
      Navigator.pop(context);
    }
  }
}
