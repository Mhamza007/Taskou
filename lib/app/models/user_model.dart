class UserModel {
  String? userName;
  String? userPassword;

  int? loginResponse;

  UserModel({
    this.userName,
    this.userPassword,
    this.loginResponse,
  });

  UserModel.fromJson(dynamic json) {
    userName = json['userName'];
    userPassword = json['userPassword'];
    loginResponse = json['response'];
  }
}
