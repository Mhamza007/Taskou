part of 'add_child_cubit.dart';

enum AddRelation {
  child,
  employee,
}

class AddChildState extends Equatable {
  const AddChildState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.addRelation,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final AddRelation? addRelation;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        addRelation,
      ];

  AddChildState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    AddRelation? addRelation,
  }) {
    return AddChildState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      addRelation: addRelation ?? this.addRelation,
    );
  }
}
