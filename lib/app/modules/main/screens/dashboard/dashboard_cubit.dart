import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this.context,
  ) : super(const DashboardState()) {
    scaffoldKey = GlobalKey<ScaffoldState>();
    _userStorage = UserStorage();

    emit(
      state.copyWith(
        themeMode: Res.appTheme.getThemeMode(),
        currentPageTitle: Res.string.findServiceman,
      ),
    );

    _getUserData();
  }

  final BuildContext context;
  FindServicemanCubit? findServicemanCubit;
  BookingsCubit? bookingsCubit;
  ProfileCubit? profileCubit;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late UserStorage _userStorage;

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

  void _getUserData() {
    var userData = _userStorage.getUserData();
    if (userData != null) {
      UserLoginData userLoginData = UserLoginData.fromMap(
        jsonDecode(userData),
      );
      emit(
        state.copyWith(
          imageUrl: userLoginData.profileImg,
          userName:
              '${userLoginData.firstName ?? ''} ${userLoginData.lastName ?? ''}',
          phoneNumber: userLoginData.userMobile,
        ),
      );
    }
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

  Future<void> logout() async {
    try {
      await Future.wait(
        [
          _userStorage.setUserId(null),
          _userStorage.setUserMobile(null),
          _userStorage.setUserToken(null),
          _userStorage.setUserType(null),
          _userStorage.setUserFirstName(null),
          _userStorage.setUserLastName(null),
          _userStorage.setUserDeviceToken(null),
          _userStorage.setUserData(jsonEncode(null)),
        ],
      );

      // Navigate to Login
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.signIn,
        (route) => false,
      );
    } catch (e) {
      debugPrint('$e');
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.errorLoggingOut,
      );
    }
  }
}
