part of 'review_cubit.dart';

class ReviewState extends Equatable {
  const ReviewState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus = ApiResponseStatus.none,
    this.rating = 0.0,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus apiResponseStatus;
  final double rating;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        rating,
      ];

  ReviewState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    double? rating,
  }) {
    return ReviewState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      rating: rating ?? this.rating,
    );
  }
}
