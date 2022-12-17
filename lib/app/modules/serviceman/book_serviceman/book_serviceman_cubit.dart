import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'book_serviceman_state.dart';

class BookServicemanCubit extends Cubit<BookServicemanState> {
  BookServicemanCubit(
    this.context, {
    required this.data,
  }) : super(const BookServicemanState()) {
    bookNowForm = BookServicemanForms.bookNowForm;
    bookLaterForm = BookServicemanForms.bookLaterForm;
    _userStorage = UserStorage();
    _bookServicemanApi = BookServicemanApi();

    var json = data['data'];
    BookServicemanType type = data['type'];

    BrowseServiceData browseServiceData = BrowseServiceData.fromJson(json);
    if (type == BookServicemanType.now) {
      bookForm = bookNowForm;
      bookNowForm.patchValue(
        {
          BookServicemanForms.handymanId: browseServiceData.handymanId,
          BookServicemanForms.handymanCity: browseServiceData.city,
        },
      );
    } else if (type == BookServicemanType.later) {
      bookForm = bookLaterForm;
      bookLaterForm.patchValue(
        {
          BookServicemanForms.handymanId: browseServiceData.handymanId,
          BookServicemanForms.handymanCity: browseServiceData.city,
        },
      );
    }

    emit(
      state.copyWith(
        servicemanType: type,
        browseServiceData: browseServiceData,
        title: data['title'],
      ),
    );
  }

  final BuildContext context;
  final Map<String, dynamic> data;
  late FormGroup bookNowForm;
  late FormGroup bookLaterForm;
  late FormGroup bookForm;
  late UserStorage _userStorage;
  late BookServicemanApi _bookServicemanApi;

  Future<void> bookHandyman() async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            Res.string.appTitle.toUpperCase(),
            style: TextStyle(
              color: Res.colors.materialColor,
            ),
          ),
          content: Text(Res.string.bookHandymanAlertMessage),
          actions: [
            CupertinoDialogAction(
              child: Text(
                Res.string.yes,
              ),
              onPressed: () async {
                Helpers.unFocus();
                Navigator.pop(context);
                if (state.servicemanType == BookServicemanType.now) {
                  await bookNow();
                } else if (state.servicemanType == BookServicemanType.later) {
                  await bookLater();
                }
              },
            ),
            CupertinoDialogAction(
              child: Text(
                Res.string.no,
              ),
              onPressed: () {
                Helpers.unFocus();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> bookNow() async {
    if (bookNowForm.valid) {
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
            var response = await _bookServicemanApi.bookHandyman(
              userToken: userToken,
              data: bookNowForm.value,
            );

            if (response.statusCode == 200 && response.data != null) {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.success,
                  message: response.message ?? Res.string.success,
                  bookingId: '${response.data!.bookingId ?? ''}',
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
      bookNowForm.markAllAsTouched();
    }
  }

  Future<void> bookLater() async {
    validateDateTime();
    if (bookLaterForm.valid) {
      if (validateDateTime()) {
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
              var response = await _bookServicemanApi.scheduleHandyman(
                userToken: userToken,
                data: bookLaterForm.value,
              );

              if (response.statusCode == 200 && response.data != null) {
                emit(
                  state.copyWith(
                    apiResponseStatus: ApiResponseStatus.success,
                    message: response.message ?? Res.string.success,
                    bookingId: '${response.data!.bookingId ?? ''}',
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
        // select date and time in future
      }
    } else {
      bookLaterForm.markAllAsTouched();
    }
    try {} catch (e) {}
  }

  Future<void> getAddress() async {
    var location = await Navigator.pushNamed(
      context,
      Routes.placesSearch,
    );
    debugPrint('$location');
    if (location != null) {
      if (state.servicemanType == BookServicemanType.now) {
        bookNowForm.patchValue(location as Map<String, dynamic>);
        debugPrint('bookNowForm ${bookNowForm.value}');
      } else if (state.servicemanType == BookServicemanType.later) {
        bookLaterForm.patchValue(location as Map<String, dynamic>);
        debugPrint('bookLaterForm ${bookLaterForm.value}');
      }
    } else {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.errorWhileGettingLocation,
      );
    }
  }

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    debugPrint('$selectedDay');
    emit(
      state.copyWith(
        dateTime: selectedDay,
      ),
    );
    var month = '${selectedDay.month}';
    if (month.length < 2) {
      month = '0$month';
    }

    var day = '${selectedDay.day}';
    if (day.length < 2) {
      day = '0$day';
    }

    bookLaterForm.patchValue(
      {
        BookServicemanForms.scheduleDate: '${selectedDay.year}-$month-$day',
      },
    );
  }

  void pickTime() async {
    var now = DateTime.now();

    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: now.hour,
        minute: now.minute,
      ),
    );

    if (time != null) {
      emit(
        state.copyWith(
          timeOfDay: time,
        ),
      );

      String hour;
      if (time.hour > 12) {
        hour = '${time.hour - 12}';
      } else {
        hour = '${time.hour}';
      }
      if (hour.length < 2) {
        hour = '0$hour';
      }
      var minute = '${time.minute}';
      if (minute.length < 2) {
        minute = '0$minute';
      }

      String ampm;
      if (time.hour >= 12) {
        ampm = 'PM';
      } else {
        ampm = 'AM';
      }

      debugPrint('$hour:$minute $ampm');

      bookLaterForm.patchValue(
        {
          BookServicemanForms.scheduleTime: '$hour:$minute $ampm',
        },
      );
    }
  }

  bool validateDateTime() {
    if (state.dateTime == null || state.timeOfDay == null) {
      return false;
    }
    var selectedDateTime = DateTime(
      state.dateTime!.year,
      state.dateTime!.month,
      state.dateTime!.day,
      state.timeOfDay!.hour,
      state.timeOfDay!.minute,
    );

    return selectedDateTime.isAfter(DateTime.now());
  }
}
