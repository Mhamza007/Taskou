part of 'bookings_cubit.dart';

enum BookingType {
  currentBooking,
  pastBooking,
  upcomingBooking,
}

class BookingsState extends Equatable {
  const BookingsState({
    this.currentLoading = true,
    this.pastLoading = true,
    this.upcomingLoading = true,
    this.message = '',
    this.apiResponseStatus,
    this.currentBookingsResponseList,
    this.pastBookingsResponseList,
    this.scheduleBookingsResponseList,
  });

  final bool currentLoading;
  final bool pastLoading;
  final bool upcomingLoading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final List<GetBookingsData>? currentBookingsResponseList;
  final List<GetBookingsData>? pastBookingsResponseList;
  final List<ScheduleBookingsData>? scheduleBookingsResponseList;

  @override
  List<Object?> get props => [
        currentLoading,
        pastLoading,
        upcomingLoading,
        message,
        apiResponseStatus,
        currentBookingsResponseList,
        pastBookingsResponseList,
        scheduleBookingsResponseList,
      ];

  BookingsState copyWith({
    bool? currentLoading,
    bool? pastLoading,
    bool? upcomingLoading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    List<GetBookingsData>? currentBookingsResponseList,
    List<GetBookingsData>? pastBookingsResponseList,
    List<ScheduleBookingsData>? scheduleBookingsResponseList,
  }) {
    return BookingsState(
      currentLoading: currentLoading ?? this.currentLoading,
      pastLoading: pastLoading ?? this.pastLoading,
      upcomingLoading: upcomingLoading ?? this.upcomingLoading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      currentBookingsResponseList:
          currentBookingsResponseList ?? this.currentBookingsResponseList,
      pastBookingsResponseList:
          pastBookingsResponseList ?? this.pastBookingsResponseList,
      scheduleBookingsResponseList:
          scheduleBookingsResponseList ?? this.scheduleBookingsResponseList,
    );
  }
}
