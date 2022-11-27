part of 'booking_status_cubit.dart';

class BookingStatusState extends Equatable {
  const BookingStatusState({
    this.loading = true,
    this.message = '',
    this.apiResponseStatus = ApiResponseStatus.none,
    this.bookingType,
    this.bookingStatusData,
    this.titlesList = const [],
  });

  final bool loading;
  final String message;
  final ApiResponseStatus apiResponseStatus;
  final BookingType? bookingType;
  final BookingStatusData? bookingStatusData;
  final List<Map<String, bool>> titlesList;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        bookingType,
        bookingStatusData,
        titlesList,
      ];

  BookingStatusState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    BookingType? bookingType,
    BookingStatusData? bookingStatusData,
    List<Map<String, bool>>? titlesList,
  }) {
    return BookingStatusState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      bookingType: bookingType ?? this.bookingType,
      bookingStatusData: bookingStatusData ?? this.bookingStatusData,
      titlesList: titlesList ?? this.titlesList,
    );
  }
}
