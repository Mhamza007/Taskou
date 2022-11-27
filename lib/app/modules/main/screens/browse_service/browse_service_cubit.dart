import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'browse_service_state.dart';

class BrowseServiceCubit extends Cubit<BrowseServiceState> {
  BrowseServiceCubit(
    this.context, {
    required this.categoryData,
  }) : super(const BrowseServiceState()) {
    _browseService = BrowseServiceApi();
    _userStorage = UserStorage();

    browseService();
  }

  final BuildContext context;
  final Map categoryData;
  late BrowseServiceApi _browseService;
  late UserStorage _userStorage;

  void back() {
    Navigator.pop(context);
  }

  Future<void> browseService() async {
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
          var response = await _browseService.getBrowseService(
            userToken: userToken,
            data: categoryData,
          );

          if (response?.statusCode == 200 &&
              response?.browseServiceData != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                browseServiceData: response?.browseServiceData,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
                browseServiceData: [],
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
              browseServiceData: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
            browseServiceData: [],
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          browseServiceData: [],
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          browseServiceData: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
          browseServiceData: [],
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
  }
}
