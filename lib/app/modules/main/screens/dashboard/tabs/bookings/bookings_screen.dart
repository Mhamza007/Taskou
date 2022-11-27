import 'package:flutter/material.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({
    super.key,
    required this.cubit,
    required this.state,
    this.themeMode,
  });

  final BookingsCubit cubit;
  final BookingsState state;
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    bool darkMode = themeMode == ThemeMode.dark;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Res.colors.materialColor,
            child: TabBar(
              indicatorWeight: 4,
              indicatorColor: Res.colors.tabIndicatorColor,
              tabs: [
                Tab(text: Res.string.current),
                Tab(text: Res.string.past),
                Tab(text: Res.string.upcoming),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                /// Current
                state.currentBookingsResponseList == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.currentBookingsResponseList!.isEmpty
                        ? Center(
                            child: Text(
                              Res.string.noDataFound,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16.0),
                            itemCount:
                                state.currentBookingsResponseList!.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16.0);
                            },
                            itemBuilder: (context, index) {
                              var item =
                                  state.currentBookingsResponseList![index];
                              return BookingsItem(
                                profileImage: item.profileImg ?? '',
                                title:
                                    '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                dateTime:
                                    Helpers.bookingsDateTime(item.createdOn),
                                location: item.address ?? '',
                                ratePerHour: item.price?.isNotEmpty == true
                                    ? '${item.price}/hour'
                                    : 'NA',
                                status: item.bookingStatus == '1'
                                    ? 'Pending'
                                    : 'Ongoing',
                                onTap: () {
                                  cubit.goToBookingStatus(
                                    bookingData: {
                                      'booking_id': item.bookingId,
                                      'booking_type':
                                          BookingType.currentBooking,
                                    },
                                  );
                                },
                              );
                            },
                          ),

                /// Past
                state.pastBookingsResponseList == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.pastBookingsResponseList!.isEmpty
                        ? Center(
                            child: Text(
                              Res.string.noDataFound,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: state.pastBookingsResponseList!.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16.0);
                            },
                            itemBuilder: (context, index) {
                              var item = state.pastBookingsResponseList![index];
                              return BookingsItem(
                                profileImage: item.profileImg ?? '',
                                title:
                                    '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                dateTime:
                                    Helpers.bookingsDateTime(item.createdOn),
                                location: item.address ?? '',
                                ratePerHour: item.price?.isNotEmpty == true
                                    ? '${item.price}/hour'
                                    : 'NA',
                                status: 'Completed',
                                onTap: () {
                                  cubit.goToBookingStatus(
                                    bookingData: {
                                      'booking_id': item.bookingId,
                                      'booking_type': BookingType.pastBooking,
                                    },
                                  );
                                },
                              );
                            },
                          ),

                /// Upcoming
                state.scheduleBookingsResponseList == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.scheduleBookingsResponseList!.isEmpty
                        ? Center(
                            child: Text(
                              Res.string.noDataFound,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16.0),
                            itemCount:
                                state.scheduleBookingsResponseList!.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16.0);
                            },
                            itemBuilder: (context, index) {
                              var item =
                                  state.scheduleBookingsResponseList![index];

                              return BookingsItem(
                                profileImage: '',
                                title:
                                    '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                dateTime:
                                    Helpers.bookingsDateTime(item.createdOn),
                                location: item.address ?? '',
                                ratePerHour: item.price?.isNotEmpty == true
                                    ? '${item.price}/hour'
                                    : 'NA',
                                status: item.bookingStatus == '1'
                                    ? 'Pending'
                                    : 'Ongoing',
                                scheduled:
                                    'Schedule at ${item.scheduleDate} ${item.scheduleTime}',
                                onTap: () {
                                  cubit.goToBookingStatus(
                                    bookingData: {
                                      'booking_id': item.bookingId,
                                      'booking_type':
                                          BookingType.upcomingBooking,
                                    },
                                  );
                                },
                              );
                            },
                          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
