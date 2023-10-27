import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'serviceman_profile_state.dart';

class ServicemanProfileCubit extends Cubit<ServicemanProfileState> {
  ServicemanProfileCubit(
    this.context, {
    required this.data,
  }) : super(const ServicemanProfileState()) {
    BrowseServiceData browseServiceData = BrowseServiceData.fromJson(
      data['data'],
    );

    emit(
      state.copyWith(
        title:
            '${browseServiceData.firstName ?? ''} ${browseServiceData.lastName ?? ''}',
        browseServiceData: browseServiceData,
      ),
    );

    _userStorage = UserStorage();
    _bookingsApi = BookingsApi();

    getHandymanReviews();
    getHandymanDetails();
  }

  final BuildContext context;
  final Map<String, dynamic> data;
  late UserStorage _userStorage;
  late BookingsApi _bookingsApi;

  void back() => Navigator.pop(context);

  void book() {
    Navigator.pushNamed(
      context,
      Routes.bookNowLater,
      arguments: {
        'data': state.browseServiceData?.toJson(),
        'title': data['title'],
      },
    );
  }

  Future<void> getHandymanReviews() async {
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
          var response = await _bookingsApi.getHandymanReviews(
            userToken: userToken,
            handymanId: data['data']['handyman_id'],
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                message: response?.message ?? Res.string.success,
                handymanReviews: response?.data?.reversed.toList(),
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
  }

  Future<void> getHandymanDetails() async {
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
          var response = await _bookingsApi.getHandymanByIdResponse(
            userToken: userToken,
            handymanId: data['data']['handyman_id'],
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                message: response?.message ?? Res.string.success,
                workPhotos: response?.data?.workPhotos,
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
  }

  double getRating(String? rating) {
    try {
      return double.parse(rating ?? '0');
    } catch (_) {
      return 0;
    }
  }
}
