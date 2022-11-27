import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'booking_status_state.dart';

class BookingStatusCubit extends Cubit<BookingStatusState> {
  BookingStatusCubit(
    this.context, {
    required this.bookingData,
  }) : super(const BookingStatusState()) {
    _bookingsApi = BookingsApi();
    _userStorage = UserStorage();

    getBookingType();
    getBookingStatus();
  }

  final BuildContext context;
  final Map bookingData;
  late BookingsApi _bookingsApi;
  late UserStorage _userStorage;

  void back() {
    Navigator.pop(context);
  }

  getBookingType() {
    BookingType bookingType = bookingData['booking_type'];
    emit(
      state.copyWith(
        bookingType: bookingType,
      ),
    );
  }

  Future<void> getBookingStatus() async {
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
          var response = await _bookingsApi.getBookingStatus(
            userToken: userToken,
            bookingData: {
              'bookingId': bookingData['booking_id'],
            },
          );

          if (response?.statusCode == 200 && response?.data != null) {
            var status = response?.data?.bookingStatus;
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                bookingStatusData: response?.data,
                titlesList: [
                  {
                    Res.string.taskAccepted: status == '2' ||
                        status == '3' ||
                        status == '4' ||
                        status == '5',
                  },
                  {
                    Res.string.handymanArrived:
                        status == '3' || status == '4' || status == '5',
                  },
                  {
                    Res.string.taskStart: status == '4' || status == '5',
                  },
                  {
                    Res.string.taskCompleted: status == '5',
                  },
                ],
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

  void goToReview() {
    Navigator.pushNamed(
      context,
      Routes.review,
      arguments: {
        'handyman_id': state.bookingStatusData?.handymanId,
        'first_name': state.bookingStatusData?.firstName,
        'last_name': state.bookingStatusData?.lastName,
      },
    );
  }
}
