part of 'book_serviceman_cubit.dart';

enum BookServicemanType {
  now,
  later,
}

class BookServicemanState extends Equatable {
  const BookServicemanState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.servicemanType,
    this.browseServiceData,
    this.title,
    this.dateTime,
    this.timeOfDay,
    this.bookingId,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final BookServicemanType? servicemanType;
  final BrowseServiceData? browseServiceData;
  final String? title;
  final DateTime? dateTime;
  final TimeOfDay? timeOfDay;
  final String? bookingId;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        servicemanType,
        browseServiceData,
        title,
        dateTime,
        timeOfDay,
        bookingId,
      ];

  BookServicemanState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    BookServicemanType? servicemanType,
    BrowseServiceData? browseServiceData,
    String? title,
    DateTime? dateTime,
    TimeOfDay? timeOfDay,
    String? bookingId,
  }) {
    return BookServicemanState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      servicemanType: servicemanType ?? this.servicemanType,
      browseServiceData: browseServiceData ?? this.browseServiceData,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}
