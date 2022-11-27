import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingStatusCubit(
        context,
        bookingData: data,
      ),
      child: BlocConsumer<BookingStatusCubit, BookingStatusState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
        listener: (context, state) {
          switch (state.apiResponseStatus) {
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
          var cubit = context.read<BookingStatusCubit>();

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
              title: Text(
                state.bookingType == BookingType.pastBooking
                    ? Res.string.pastTask
                    : state.bookingType == BookingType.currentBooking
                        ? Res.string.currentTask
                        : state.bookingType == BookingType.upcomingBooking
                            ? Res.string.upcomingTask
                            : '',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              centerTitle: true,
            ),
            body: state.bookingStatusData == null && state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.bookingStatusData == null && !state.loading
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Res.string.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            state.bookingStatusData?.message ?? '',
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Res.colors.lightGreyColor,
                              ),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 1,
                                  color: Res.colors.lightGreyColor,
                                  indent: 12.0,
                                  endIndent: 12.0,
                                );
                              },
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    state.titlesList[index].keys.last,
                                  ),
                                  trailing: Container(
                                    height: 24.0,
                                    width: 24.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Res.colors.materialColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: state.titlesList[index].values.last
                                          ? Res.colors.materialColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          state.bookingType == BookingType.pastBooking
                              ? SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: cubit.goToReview,
                                    child: Text(
                                      Res.string.review,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ).paddingSymmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
          );
        },
      ),
    );
  }
}
