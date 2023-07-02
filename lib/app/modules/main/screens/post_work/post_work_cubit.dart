import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'post_work_state.dart';

class PostWorkCubit extends Cubit<PostWorkState> {
  PostWorkCubit(
    this.context, {
    required this.categoryData,
  }) : super(const PostWorkState()) {
    postWorkForm = PostWorkForms.postWorkForm;
    _userStorage = UserStorage();
    _postWorkApi = PostWorkApi();

    postWorkForm.patchValue(categoryData);
    postWorkForm.patchValue({PostWorkForms.bookingType: '1'});
  }

  final BuildContext context;
  final Map<String, dynamic> categoryData;
  late FormGroup postWorkForm;
  late UserStorage _userStorage;
  late PostWorkApi _postWorkApi;

  void back() {
    Navigator.pop(context);
  }

  Future<void> getAddress() async {
    var location = await Navigator.pushNamed(
      context,
      Routes.placesSearch,
    );
    debugPrint('$location');
    if (location != null) {
      postWorkForm.patchValue(location as Map<String, dynamic>);
      debugPrint('${postWorkForm.value}');
    } else {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.errorWhileGettingLocation,
      );
    }
  }

  Future<void> postWork() async {
    if (postWorkForm.valid) {
      try {
        emit(
          state.copyWith(
            loading: true,
          ),
        );

        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          var userToken = _userStorage.getUserToken();
          if (userToken != null) {
            var response = await _postWorkApi.postWork(
              userToken: userToken,
              data: postWorkForm.value,
            );

            if (response?.statusCode == 200 && response?.data != null) {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.success,
                  message: response?.message ?? Res.string.success,
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
                message: Res.string.userAuthFailedLoginAgain,
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
            apiResponseStatus: ApiResponseStatus.none,
          ),
        );
      }
    } else {
      postWorkForm.markAllAsTouched();
    }
  }
}
