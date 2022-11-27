part of 'browse_service_cubit.dart';

class BrowseServiceState extends Equatable {
  const BrowseServiceState({
    this.loading = true,
    this.message = '',
    this.apiResponseStatus,
    this.browseServiceData,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final List<BrowseServiceData>? browseServiceData;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        browseServiceData,
      ];

  BrowseServiceState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    List<BrowseServiceData>? browseServiceData,
  }) {
    return BrowseServiceState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      browseServiceData: browseServiceData ?? this.browseServiceData,
    );
  }
}
