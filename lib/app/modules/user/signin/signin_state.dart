part of 'signin_cubit.dart';

enum SignInStatus {
  signInLoading,
  loaded,
}

class SignInState extends Equatable {
  const SignInState({
    this.status = SignInStatus.loaded,
    this.authStatus = AuthStatus.none,
    this.authMessage = '',
    this.obscurePassword = true,
    this.appVersion = '',
    this.countryCode,
    this.flag,
    this.hint,
    this.maxLength,
    this.exampleNumber,
  });

  final SignInStatus status;
  final AuthStatus authStatus;
  final String authMessage;
  final bool obscurePassword;
  final String appVersion;
  final String? countryCode;
  final String? flag;
  final String? hint;
  final int? maxLength;
  final String? exampleNumber;

  SignInState copyWith({
    SignInStatus? status,
    AuthStatus? authStatus,
    String? authMessage,
    bool? obscurePassword,
    String? appVersion,
    String? countryCode,
    String? flag,
    String? hint,
    int? maxLength,
    String? exampleNumber,
  }) {
    return SignInState(
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      authMessage: authMessage ?? this.authMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      appVersion: appVersion ?? this.appVersion,
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      hint: hint ?? this.hint,
      maxLength: maxLength ?? this.maxLength,
      exampleNumber: exampleNumber ?? this.exampleNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        authStatus,
        authMessage,
        obscurePassword,
        appVersion,
        countryCode,
        flag,
        hint,
        maxLength,
      ];
}
