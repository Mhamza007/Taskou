import 'package:flutter/material.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

class BookingsScreen extends StatefulWidget {
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
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      widget.cubit
        ..getBookings()
        ..getScheduleBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.themeMode == ThemeMode.dark;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Res.colors.materialColor,
            child: TabBar(
              controller: _tabController,
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
              controller: _tabController,
              children: [
                /// Current
                RefreshIndicator(
                  onRefresh: () async {
                    widget.cubit.getBookings();
                    widget.cubit.getScheduleBookings();
                  },
                  child: widget.state.currentBookingsResponseList == null ||
                          widget.state.currentLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.state.currentBookingsResponseList!.isEmpty
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
                              itemCount: widget
                                  .state.currentBookingsResponseList!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = widget
                                    .state.currentBookingsResponseList![index];
                                return BookingsItem(
                                  profileImage: item.profileImg ?? '',
                                  title:
                                      '${item.firstName ?? ''} ${item.lastName ?? ''}',
                                  location: item.address ?? '',
                                  ratePerHour: item.price?.isNotEmpty == true
                                      ? '${item.price}/hour'
                                      : 'NA',
                                  status: item.bookingStatus == '1'
                                      ? 'Pending'
                                      : 'Ongoing',
                                  onTap: () {
                                    widget.cubit.goToBookingStatus(
                                      bookingData: {
                                        'booking_id': item.bookingId,
                                        'booking_type':
                                            BookingType.currentBooking,
                                        'contact':
                                            '${item.countryCode}${item.userMobile}'
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                ),

                /// Past
                RefreshIndicator(
                  onRefresh: () async {
                    widget.cubit.getBookings();
                    widget.cubit.getScheduleBookings();
                  },
                  child: widget.state.pastBookingsResponseList == null ||
                          widget.state.pastLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.state.pastBookingsResponseList!.isEmpty
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
                                  widget.state.pastBookingsResponseList!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = widget
                                    .state.pastBookingsResponseList![index];
                                return BookingsItem(
                                  profileImage: item.profileImg ?? '',
                                  title:
                                      '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                  location: item.address ?? '',
                                  ratePerHour: item.price?.isNotEmpty == true
                                      ? '${item.price}/hour'
                                      : 'NA',
                                  status: 'Completed',
                                  onTap: () {
                                    widget.cubit.goToBookingStatus(
                                      bookingData: {
                                        'booking_id': item.bookingId,
                                        'booking_type': BookingType.pastBooking,
                                        'contact':
                                            '${item.countryCode}${item.userMobile}'
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                ),

                /// Upcoming
                RefreshIndicator(
                  onRefresh: () async {
                    widget.cubit.getBookings();
                    widget.cubit.getScheduleBookings();
                  },
                  child: widget.state.scheduleBookingsResponseList == null ||
                          widget.state.upcomingLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.state.scheduleBookingsResponseList!.isEmpty
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
                              itemCount: widget
                                  .state.scheduleBookingsResponseList!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = widget
                                    .state.scheduleBookingsResponseList![index];

                                return BookingsItem(
                                  profileImage: '',
                                  title:
                                      '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                  dateTime: Helpers.getScheduleDateTime(
                                    scheduleDate: item.scheduleDate,
                                    scheduleTime: item.scheduleTime,
                                  ),
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
                                    widget.cubit.goToBookingStatus(
                                      bookingData: {
                                        'booking_id': item.bookingId,
                                        'booking_type':
                                            BookingType.upcomingBooking,
                                        'contact': null,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
