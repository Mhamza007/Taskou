import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;
import 'package:table_calendar/table_calendar.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class BookServicemanScreen extends StatelessWidget {
  const BookServicemanScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    return BlocProvider(
      create: (context) => BookServicemanCubit(
        context,
        data: data,
      ),
      child: BlocConsumer<BookServicemanCubit, BookServicemanState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
        listener: (context, state) {
          switch (state.apiResponseStatus) {
            case ApiResponseStatus.success:
              showCupertinoDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      Res.string.appTitle.toUpperCase(),
                      style: TextStyle(
                        color: Res.colors.materialColor,
                      ),
                    ),
                    content: Text(state.message),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          Res.string.ok,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.bookingStatus,
                            arguments: {
                              'booking_id': state.bookingId,
                              'booking_type': state.servicemanType ==
                                      BookServicemanType.later
                                  ? BookingType.upcomingBooking
                                  : BookingType.currentBooking,
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
              break;
            case ApiResponseStatus.failure:
              Helpers.errorSnackBar(
                context: context,
                title: state.message,
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          var cubit = context.read<BookServicemanCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: cubit.back,
                child: SvgPicture.asset(
                  Res.drawable.back,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(Res.string.bookServiceman),
            ),
            body: forms.ReactiveForm(
              formGroup: cubit.bookForm,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                children: [
                  Text(
                    '${state.browseServiceData?.firstName ?? ''} ${state.browseServiceData?.lastName ?? ''}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Res.colors.materialColor,
                      fontSize: 32.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    state.title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Res.colors.darkGreyColor,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (state.servicemanType == BookServicemanType.later)
                    TableCalendar(
                      focusedDay: state.dateTime ?? DateTime.now(),
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2030),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      rangeSelectionMode: RangeSelectionMode.disabled,
                      onDaySelected: cubit.onDaySelected,
                      selectedDayPredicate: (day) {
                        return isSameDay(
                          state.dateTime ?? DateTime.now(),
                          day,
                        );
                      },
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarBuilders: CalendarBuilders(
                        todayBuilder: (context, day, focusedDay) {
                          return Center(
                            child: CircleAvatar(
                              backgroundColor:
                                  Res.colors.materialColor.withOpacity(0.2),
                              child: Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Res.colors.textColorDark
                                      : Res.colors.textColor,
                                ),
                              ),
                            ),
                          );
                        },
                        selectedBuilder: (context, day, focusedDay) {
                          return Center(
                            child: CircleAvatar(
                              child: Text(
                                '${day.day}',
                              ),
                            ),
                          );
                        },
                      ),
                    ).marginOnly(
                      bottom: 16.0,
                    ),
                  if (state.servicemanType == BookServicemanType.later)
                    ReactiveTextField(
                      formControlName: BookServicemanForms.scheduleTime,
                      readOnly: true,
                      onTap: (control) {
                        cubit.pickTime();
                      },
                      decoration: InputDecoration(
                        hintText: Res.string.enterTime,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                      ),
                      validationMessages: {
                        forms.ValidationMessage.required: (_) =>
                            Res.string.thisFieldIsRequired,
                      },
                    ).marginOnly(
                      bottom: 16.0,
                    ),
                  ReactiveTextField(
                    formControlName: BookServicemanForms.address,
                    readOnly: true,
                    onTap: (control) {
                      cubit.getAddress();
                    },
                    decoration: InputDecoration(
                      hintText: Res.string.enterAddress,
                      border: inputBorder,
                      enabledBorder: inputBorder,
                    ),
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ReactiveTextField(
                    formControlName: BookServicemanForms.message,
                    decoration: InputDecoration(
                      hintText: Res.string.enterYourMessage,
                      border: inputBorder,
                      enabledBorder: inputBorder,
                    ),
                    maxLines: 6,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              width: double.maxFinite,
              height: 48.0,
              margin: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: cubit.bookHandyman,
                child: state.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Res.colors.whiteColor,
                        ),
                      )
                    : Text(
                        Res.string.book,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
