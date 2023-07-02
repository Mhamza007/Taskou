part of 'find_serviceman_cubit.dart';

class FindServicemanState extends Equatable {
  const FindServicemanState({
    this.loading = true,
    this.subLoading = false,
    this.isSearching = false,
    this.categories,
    this.filterList,
    this.message = '',
    this.apiResponseStatus,
  });

  final bool loading;
  final bool subLoading;
  final bool isSearching;
  final List<CategoriesResponseData>? categories;
  final List<CategoriesResponseData>? filterList;
  final String message;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        loading,
        subLoading,
        isSearching,
        categories,
        filterList,
        message,
        apiResponseStatus,
      ];

  FindServicemanState copyWith({
    bool? loading,
    bool? subLoading,
    bool? isSearching,
    List<CategoriesResponseData>? categories,
    List<CategoriesResponseData>? filterList,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return FindServicemanState(
      loading: loading ?? this.loading,
      subLoading: subLoading ?? this.subLoading,
      isSearching: isSearching ?? this.isSearching,
      categories: categories ?? this.categories,
      filterList: filterList ?? this.filterList,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
