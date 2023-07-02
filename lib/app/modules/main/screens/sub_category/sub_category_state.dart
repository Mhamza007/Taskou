part of 'sub_category_cubit.dart';

class SubCategoryState extends Equatable {
  const SubCategoryState({
    this.loading = false,
    this.page = 0,
    this.title = '',
    this.message = '',
    this.sub2CategoryName = '',
    this.sub3CategoryName = '',
    this.subCategoriesList,
    this.sub2CategoriesList,
    this.sub3CategoriesList,
    this.apiResponseStatus,
  });

  final bool loading;
  final int page;
  final String title;
  final String message;
  final String sub2CategoryName;
  final String sub3CategoryName;
  final List<SubCategoriesData>? subCategoriesList;
  final List<Sub2CategoriesData>? sub2CategoriesList;
  final List<Sub3CategoriesData>? sub3CategoriesList;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        loading,
        page,
        title,
        message,
        sub2CategoryName,
        sub3CategoryName,
        subCategoriesList,
        sub2CategoriesList,
        sub3CategoriesList,
        apiResponseStatus,
      ];

  SubCategoryState copyWith({
    bool? loading,
    int? page,
    String? title,
    String? message,
    String? sub2CategoryName,
    String? sub3CategoryName,
    List<SubCategoriesData>? subCategoriesList,
    List<Sub2CategoriesData>? sub2CategoriesList,
    List<Sub3CategoriesData>? sub3CategoriesList,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return SubCategoryState(
      loading: loading ?? this.loading,
      page: page ?? this.page,
      title: title ?? this.title,
      message: message ?? this.message,
      sub2CategoryName: sub2CategoryName ?? this.sub2CategoryName,
      sub3CategoryName: sub3CategoryName ?? this.sub3CategoryName,
      subCategoriesList: subCategoriesList ?? this.subCategoriesList,
      sub2CategoriesList: sub2CategoriesList ?? this.sub2CategoriesList,
      sub3CategoriesList: sub3CategoriesList ?? this.sub3CategoriesList,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
