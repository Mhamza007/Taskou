// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'add_child_state.dart';

class AddChildCubit extends Cubit<AddChildState> {
  AddChildCubit(
    this.context,
  ) : super(const AddChildState()) {
    addChildForm = AddChildForm.addChildForm;
    _trackingServiceApi = TrackingServiceApi();
    _userStorage = UserStorage();

    _getThemeMode();
  }

  final BuildContext context;
  late TrackingServiceApi _trackingServiceApi;
  late UserStorage _userStorage;
  late final FormGroup addChildForm;
  late bool darkMode;

  void back() => Navigator.pop(context);

  _getThemeMode() {
    darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;
  }

  chooseRelation() async {
    AddRelation? addRelation = await Get.bottomSheet(
      backgroundColor: Colors.white,
      ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Center(
              child: Text(
                Res.string.relation,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(Res.string.child),
            onTap: () => Navigator.pop(
              context,
              AddRelation.child,
            ),
          ),
          ListTile(
            title: Text(Res.string.employee),
            onTap: () => Navigator.pop(
              context,
              AddRelation.employee,
            ),
          ),
        ],
      ),
    );

    if (addRelation != null) {
      if (addRelation == AddRelation.child) {
        addChildForm.patchValue({
          AddChildForm.relationControl: Res.string.child,
        });
      } else if (addRelation == AddRelation.employee) {
        addChildForm.patchValue({
          AddChildForm.relationControl: Res.string.employee,
        });
      }
    }
  }

  Future<void> addChild() async {
    if (addChildForm.valid) {
      debugPrint('${addChildForm.value}');
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
            var response = await _trackingServiceApi.addChild(
              userToken: userToken,
              data: addChildForm.value,
            );

            if (response?.statusCode == 200) {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.success,
                  message: response?.message ?? Res.string.success,
                ),
              );
              Navigator.pop(context, true);
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
      addChildForm.markAllAsTouched();
    }
  }
}
