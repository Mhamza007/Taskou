part of 'child_mode_cubit.dart';

class ChildModeState extends Equatable {
  const ChildModeState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus = ApiResponseStatus.none,
    this.childModeData,
  });
  final bool loading;
  final String message;
  final ApiResponseStatus apiResponseStatus;
  final ChildModeData? childModeData;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        childModeData,
      ];

  ChildModeState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    ChildModeData? childModeData,
  }) {
    return ChildModeState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      childModeData: childModeData ?? this.childModeData,
    );
  }
}
