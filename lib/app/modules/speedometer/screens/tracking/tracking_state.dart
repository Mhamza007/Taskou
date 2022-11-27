part of 'tracking_cubit.dart';

class TrackingState extends Equatable {
  const TrackingState({
    this.loading = true,
    this.isSearching = false,
    this.message = '',
    this.apiResponseStatus,
    this.trackingData,
    this.filterData,
  });

  final bool loading;
  final bool isSearching;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final List<TrackingResponseData>? trackingData;
  final List<TrackingResponseData>? filterData;

  @override
  List<Object?> get props => [
        loading,
        isSearching,
        message,
        apiResponseStatus,
        trackingData,
        filterData,
      ];

  TrackingState copyWith({
    bool? loading,
    bool? isSearching,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    List<TrackingResponseData>? trackingData,
    List<TrackingResponseData>? filterData,
  }) {
    return TrackingState(
      loading: loading ?? this.loading,
      isSearching: isSearching ?? this.isSearching,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      trackingData: trackingData ?? this.trackingData,
      filterData: filterData ?? this.filterData,
    );
  }
}
