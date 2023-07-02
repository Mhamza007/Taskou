part of 'post_work_cubit.dart';

class PostWorkState extends Equatable {
  const PostWorkState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
      ];

  PostWorkState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return PostWorkState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
