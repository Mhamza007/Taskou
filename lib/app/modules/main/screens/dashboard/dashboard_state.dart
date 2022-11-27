part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.themeMode,
    this.selectedIndex = 0,
    this.editMode = false,
    this.currentPageTitle = '',
  });

  final ThemeMode? themeMode;
  final int selectedIndex;
  final bool editMode;
  final String currentPageTitle;

  @override
  List<Object?> get props => [
        themeMode,
        selectedIndex,
        editMode,
        currentPageTitle,
      ];

  DashboardState copyWith({
    ThemeMode? themeMode,
    int? selectedIndex,
    bool? editMode,
    String? currentPageTitle,
  }) {
    return DashboardState(
      themeMode: themeMode ?? this.themeMode,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      editMode: editMode ?? this.editMode,
      currentPageTitle: currentPageTitle ?? this.currentPageTitle,
    );
  }
}
