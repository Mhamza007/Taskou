import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../db/db.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../sdk/sdk.dart';
import '../../../../../../app.dart';

part 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(
    this.context,
  ) : super(const BookingsState()) {
    _bookingsApi = BookingsApi();
    _userStorage = UserStorage();

    getBookings();
    getScheduleBookings();
  }

  final BuildContext context;
  late BookingsApi _bookingsApi;
  late UserStorage _userStorage;

  Future<void> getBookings() async {
    try {
      emit(
        state.copyWith(
          currentLoading: true,
          pastLoading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null) {
          var response = await _bookingsApi.getBookings(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            var currentList = <GetBookingsData>[];
            var pastList = <GetBookingsData>[];

            for (var element in response!.data!) {
              if (element.bookingStatus == '5') {
                pastList.add(element);
              } else {
                currentList.add(element);
              }
            }

            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                currentBookingsResponseList: currentList,
                pastBookingsResponseList: pastList,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
                currentBookingsResponseList: [],
                pastBookingsResponseList: [],
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
              currentBookingsResponseList: [],
              pastBookingsResponseList: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
            currentBookingsResponseList: [],
            pastBookingsResponseList: [],
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          currentBookingsResponseList: [],
          pastBookingsResponseList: [],
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          currentBookingsResponseList: [],
          pastBookingsResponseList: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
          currentBookingsResponseList: [],
          pastBookingsResponseList: [],
        ),
      );
    } finally {
      emit(
        state.copyWith(
          currentLoading: false,
          pastLoading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  Future<void> getScheduleBookings() async {
    try {
      emit(
        state.copyWith(
          upcomingLoading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null) {
          var response = await _bookingsApi.getScheduleBookings(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                scheduleBookingsResponseList: response?.data,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
                scheduleBookingsResponseList: [],
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
              scheduleBookingsResponseList: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
            scheduleBookingsResponseList: [],
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          scheduleBookingsResponseList: [],
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          scheduleBookingsResponseList: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
          scheduleBookingsResponseList: [],
        ),
      );
    } finally {
      emit(
        state.copyWith(
          upcomingLoading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  void goToBookingStatus({
    required Map bookingData,
  }) {
    Navigator.pushNamed(
      context,
      Routes.bookingStatus,
      arguments: bookingData,
    );
  }
}
