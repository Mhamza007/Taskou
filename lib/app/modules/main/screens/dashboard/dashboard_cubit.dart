import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this.context,
  ) : super(const DashboardState()) {
    scaffoldKey = GlobalKey<ScaffoldState>();

    emit(
      state.copyWith(
        themeMode: Res.appTheme.getThemeMode(),
        currentPageTitle: Res.string.findServiceman,
      ),
    );
  }

  final BuildContext context;
  FindServicemanCubit? findServicemanCubit;
  BookingsCubit? bookingsCubit;
  ProfileCubit? profileCubit;
  late final GlobalKey<ScaffoldState> scaffoldKey;

  void initFindServicemanCubit(FindServicemanCubit findServicemanCubit) {
    this.findServicemanCubit = findServicemanCubit;
  }

  void initBookingsCubit(BookingsCubit bookingsCubit) {
    this.bookingsCubit = bookingsCubit;
  }

  void initProfileCubit(ProfileCubit profileCubit) {
    this.profileCubit = profileCubit;
  }

  void changeThemeMode(ThemeMode themeMode) {
    Res.appTheme.changeThemeMode(themeMode);
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }

  void onItemSelected(int index) {
    emit(
      state.copyWith(
        selectedIndex: index,
        currentPageTitle: index == 1
            ? Res.string.bookings
            : index == 2
                ? Res.string.profile
                : Res.string.findServiceman,
      ),
    );
  }

  void enableEditing() {
    emit(
      state.copyWith(
        editMode: true,
      ),
    );
  }

  void saveEditing() {
    emit(
      state.copyWith(
        editMode: false,
      ),
    );
  }

  void showBottomSheetPopup({
    Function()? browseService,
    Function()? postWork,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(48),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ElevatedButton(
              onPressed: browseService,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 16,
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              child: Text(
                Res.string.browseService,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: postWork,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 16,
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              child: Text(
                Res.string.postWork,
              ),
            ),
          ],
        );
      },
    );
  }
}
