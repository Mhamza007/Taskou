part of 'serviceman_profile_cubit.dart';

class ServicemanProfileState extends Equatable {
  const ServicemanProfileState({
    this.loading = true,
    this.message = '',
    this.apiResponseStatus = ApiResponseStatus.none,
    this.title = '',
    this.browseServiceData,
    this.handymanReviews,
    this.workPhotos,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus apiResponseStatus;
  final String title;
  final BrowseServiceData? browseServiceData;
  final List<HandymanReviewData>? handymanReviews;
  final List<WorkPhotosById?>? workPhotos;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        title,
        browseServiceData,
        handymanReviews,
        workPhotos,
      ];

  ServicemanProfileState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    String? title,
    BrowseServiceData? browseServiceData,
    List<HandymanReviewData>? handymanReviews,
    List<WorkPhotosById?>? workPhotos,
  }) {
    return ServicemanProfileState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      title: title ?? this.title,
      browseServiceData: browseServiceData ?? this.browseServiceData,
      handymanReviews: handymanReviews ?? this.handymanReviews,
      workPhotos: workPhotos ?? this.workPhotos,
    );
  }
}
