part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
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

  ChangePasswordState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return ChangePasswordState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
