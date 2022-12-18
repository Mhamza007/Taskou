part of 'support_cubit.dart';

class SupportState extends Equatable {
  const SupportState({
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

  SupportState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return SupportState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
