import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'child_mode_state.dart';

class ChildModeCubit extends Cubit<ChildModeState> {
  ChildModeCubit(
    this.context,
  ) : super(const ChildModeState()) {
    childModeForm = ChildModeForms.codeForm;

    _trackingServiceApi = TrackingServiceApi();
  }

  final BuildContext context;
  late final FormGroup childModeForm;
  late TrackingServiceApi _trackingServiceApi;

  Future<void> submit() async {
    if (childModeForm.valid) {
      debugPrint('${childModeForm.value}');
      try {
        emit(
          state.copyWith(
            loading: true,
          ),
        );
        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          var response = await _trackingServiceApi.childMode(
            data: childModeForm.value,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                message: response?.message ?? Res.string.success,
                childModeData: response?.data,
              ),
            );

            // ignore: use_build_context_synchronously
            Navigator.pushNamed(
              context,
              Routes.speedometerMap,
              arguments: {
                'data': response?.data,
                'mode': TrackingMode.childMode,
              },
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
              ),
            );
          }
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
      childModeForm.markAllAsTouched();
    }
  }
}
