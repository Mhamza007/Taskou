// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

const String USER_BOX = 'user';
const String USER_ID = 'user_id';
const String USER_MOBILE = 'user_mobile';
const String USER_TOKEN = 'user_token';
const String USER_TYPE = 'user_type';
const String USER_FIRST_NAME = 'first_name';
const String USER_LAST_NAME = 'last_name';
const String USER_DEVICE_TOKEN = 'device_token';
const String USER_DATA = 'user_data';

class UserStorage {
  UserStorage() {
    box = GetStorage(USER_BOX);
  }

  GetStorage? box;

  Future<void> setUserId(String? userId) async {
    await box?.write(USER_ID, userId);
  }

  String? getUserId() {
    return box?.read(USER_ID);
  }

  Future<void> setUserMobile(String? userMobile) async {
    await box?.write(USER_MOBILE, userMobile);
  }

  String? getUserMobile() {
    return box?.read(USER_MOBILE);
  }

  Future<void> setUserToken(String? userToken) async {
    await box?.write(USER_TOKEN, userToken);
  }

  String? getUserToken() {
    return box?.read(USER_TOKEN);
  }

  Future<void> setUserType(String? userType) async {
    await box?.write(USER_TYPE, userType);
  }

  String? getUserType() {
    return box?.read(USER_TYPE);
  }

  Future<void> setUserFirstName(String? userFirstName) async {
    await box?.write(USER_FIRST_NAME, userFirstName);
  }

  String? getUserFirstName() {
    return box?.read(USER_FIRST_NAME);
  }

  Future<void> setUserLastName(String? userLastName) async {
    await box?.write(USER_LAST_NAME, userLastName);
  }

  String? getUserLastName() {
    return box?.read(USER_LAST_NAME);
  }

  Future<void> setUserDeviceToken(String? deviceToken) async {
    await box?.write(USER_DEVICE_TOKEN, deviceToken);
  }

  String? getDeviceToken() {
    return box?.read(USER_DEVICE_TOKEN);
  }

  Future<void> setUserData(String? userData) async {
    await box?.write(USER_DATA, userData);
  }

  String? getUserData() {
    return box?.read(USER_DATA);
  }
}
