import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
    _userApi = UserApi();

    emit(
      state.copyWith(
        themeMode: Res.appTheme.getThemeMode(),
        currentPageTitle: Res.string.appTitle,
      ),
    );

    _getUserData();
    try {
      initializeFirebaseMessagingService();
    } catch (_) {}
  }

  final BuildContext context;
  FindServicemanCubit? findServicemanCubit;
  BookingsCubit? bookingsCubit;
  ProfileCubit? profileCubit;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late UserStorage _userStorage;
  late UserApi _userApi;

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
    if (index == 1) {
      bookingsCubit?.getBookings();
      bookingsCubit?.getScheduleBookings();
    }
    emit(
      state.copyWith(
        selectedIndex: index,
        currentPageTitle: index == 1
            ? Res.string.bookings
            : index == 2
                ? Res.string.profile
                : Res.string.appTitle,
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

  Future<void> saveEditing() async {
    if (profileCubit != null) {
      if (profileCubit!.profileForm.valid) {
        try {
          profileCubit!.emit(
            profileCubit!.state.copyWith(
              loading: true,
            ),
          );

          var isConnected = await NetworkService().getConnectivity();
          if (isConnected) {
            var userToken = _userStorage.getUserToken();
            if (userToken != null) {
              var response = await _userApi.updateProfile(
                userToken: userToken,
                data: profileCubit!.profileForm.value,
              );
              if (response.statusCode == 200 && response.data != null) {
                profileCubit!.emit(
                  profileCubit!.state.copyWith(
                    apiResponseStatus: ApiResponseStatus.success,
                    message: response.message ?? Res.string.success,
                  ),
                );
                // Update user data in local db
                var userDataString = _userStorage.getUserData();
                if (userDataString != null) {
                  UserLoginData userLoginData = UserLoginData.fromMap(
                    jsonDecode(userDataString),
                  );
                  userLoginData.userId = response.data!.userId;
                  userLoginData.firstName = response.data!.firstName;
                  userLoginData.lastName = response.data!.lastName;
                  userLoginData.email = response.data!.email;
                  userLoginData.city = response.data!.city;
                  userLoginData.province = response.data!.province;
                  userLoginData.zipCode = response.data!.zipCode;
                  userLoginData.countryCode = response.data!.countryCode;
                  userLoginData.userMobile = response.data!.userMobile;
                  userLoginData.profileImg = response.data!.profileImg;
                  await Future.wait(
                    [
                      _userStorage.setUserMobile(response.data!.userMobile),
                      _userStorage.setUserFirstName(response.data!.firstName),
                      _userStorage.setUserLastName(response.data!.lastName),
                      _userStorage.setUserData(
                        jsonEncode(userLoginData.toMap()),
                      ),
                    ],
                  );
                }
              } else {
                profileCubit!.emit(
                  profileCubit!.state.copyWith(
                    apiResponseStatus: ApiResponseStatus.failure,
                    message: response.message ?? Res.string.apiErrorMessage,
                  ),
                );
              }
            } else {
              profileCubit!.emit(
                profileCubit!.state.copyWith(
                  apiResponseStatus: ApiResponseStatus.failure,
                  message: Res.string.userAuthFailedLoginAgain,
                ),
              );
            }
          } else {
            profileCubit!.emit(
              profileCubit!.state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: Res.string.youAreInOfflineMode,
              ),
            );
          }
        } on NetworkException catch (e) {
          profileCubit!.emit(
            profileCubit!.state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: e.toString(),
            ),
          );
        } on ResponseException catch (e) {
          profileCubit!.emit(
            profileCubit!.state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: e.toString(),
            ),
          );
        } catch (e) {
          profileCubit!.emit(
            profileCubit!.state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.apiErrorMessage,
            ),
          );
        } finally {
          profileCubit!.emit(
            profileCubit!.state.copyWith(
              loading: false,
              apiResponseStatus: ApiResponseStatus.none,
            ),
          );
          emit(
            state.copyWith(
              editMode: false,
            ),
          );
        }
      } else {
        profileCubit!.profileForm.markAllAsTouched();
      }
    }
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
          padding: const EdgeInsets.symmetric(
            vertical: 48.0,
            horizontal: 16.0,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ElevatedButton(
              onPressed: browseService,
              style: ElevatedButton.styleFrom(
                backgroundColor: Res.colors.tabIndicatorColor,
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                Res.string.browseService,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: postWork,
              style: ElevatedButton.styleFrom(
                backgroundColor: Res.colors.tabIndicatorColor,
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                Res.string.browseServiceFrom,
              ),
            ),
          ],
        );
      },
    );
  }

  void home() {
    Navigator.pop(context);
    onItemSelected(0);
  }

  void support() {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.support);
  }

  Future<void> help() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.help);
  }

  void changeLanguage() {
    var language = AppLanguage.en;
    var locale = Res.appTranslations.getLocale();
    if (locale == const Locale('fr')) {
      language = AppLanguage.fr;
    }

    Get.back();

    Get.dialog(
      CupertinoAlertDialog(
        title: Text(Res.string.changeLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioMenuButton(
              value: AppLanguage.en,
              groupValue: language,
              onChanged: (AppLanguage? appLanguage) async {
                language = AppLanguage.en;
                await Res.appTranslations.updateLocale(langCode: 'en');
                Get.back();
              },
              child: const Text('English'),
            ),
            RadioMenuButton(
              value: AppLanguage.fr,
              groupValue: language,
              onChanged: (AppLanguage? appLanguage) async {
                language = AppLanguage.fr;
                await Res.appTranslations.updateLocale(langCode: 'fr');
                Get.back();
              },
              child: const Text('Français'),
            ),
          ],
        ),
      ),
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
          _userStorage.setUserData(null),
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
