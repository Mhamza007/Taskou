import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(
    this.context,
  ) : super(const ChangePasswordState()) {
    forgotPasswordForm = ForgotPasswordForm.forgotPasswordForm;
    _userApi = UserApi();
    _userStorage = UserStorage();
  }

  final BuildContext context;
  late final FormGroup forgotPasswordForm;
  late final UserApi _userApi;
  late UserStorage _userStorage;

  void back() => Navigator.pop(context);

  Future<void> submit() async {
    if (forgotPasswordForm.valid) {
      debugPrint('forgotPasswordForm ${forgotPasswordForm.value}');
      forgotPasswordForm.unfocus();

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
            var response = await _userApi.changePassword(
              userToken: userToken,
              data: forgotPasswordForm.value,
            );

            if (response.statusCode == 200) {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.success,
                  message: response.message ?? Res.string.success,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.failure,
                  message: response.message ?? Res.string.apiErrorMessage,
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
      forgotPasswordForm.markAllAsTouched();
    }
  }
}
