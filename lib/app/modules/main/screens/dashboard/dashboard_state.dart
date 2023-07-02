part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.themeMode,
    this.selectedIndex = 0,
    this.editMode = false,
    this.currentPageTitle = '',
    this.userName = '',
    this.phoneNumber = '',
    this.imageUrl,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final ThemeMode? themeMode;
  final int selectedIndex;
  final bool editMode;
  final String currentPageTitle;
  final String userName;
  final String phoneNumber;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        themeMode,
        selectedIndex,
        editMode,
        currentPageTitle,
        userName,
        phoneNumber,
        imageUrl,
      ];

  DashboardState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    ThemeMode? themeMode,
    int? selectedIndex,
    bool? editMode,
    String? currentPageTitle,
    String? userName,
    String? phoneNumber,
    String? imageUrl,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      themeMode: themeMode ?? this.themeMode,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      editMode: editMode ?? this.editMode,
      currentPageTitle: currentPageTitle ?? this.currentPageTitle,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'DashboardState(themeMode: $themeMode, selectedIndex: $selectedIndex, editMode: $editMode, currentPageTitle: $currentPageTitle, userName: $userName, phoneNumber: $phoneNumber, imageUrl: $imageUrl)';
  }
}
