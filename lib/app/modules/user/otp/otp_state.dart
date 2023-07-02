part of 'otp_cubit.dart';

enum VerifyStatus {
  loading,
  loaded,
}

class OtpState extends Equatable {
  const OtpState({
    this.status = VerifyStatus.loaded,
    this.authStatus = AuthStatus.none,
    this.authMessage = '',
    this.userData,
    this.verificationId,
    this.phoneNumber,
    this.buttonEnabled = false,
    this.seconds = 60,
    this.timeUp = false,
    this.userId,
    this.otp,
  });

  final VerifyStatus status;
  final AuthStatus authStatus;
  final String authMessage;
  final Map<String, dynamic>? userData;
  final String? verificationId;
  final String? phoneNumber;
  final bool buttonEnabled;
  final int seconds;
  final bool timeUp;
  final String? userId;
  final String? otp;

  @override
  List<Object?> get props => [
        status,
        authStatus,
        authMessage,
        userData,
        verificationId,
        phoneNumber,
        buttonEnabled,
        seconds,
        timeUp,
        userId,
        otp,
      ];

  OtpState copyWith({
    VerifyStatus? status,
    AuthStatus? authStatus,
    String? authMessage,
    Map<String, dynamic>? userData,
    String? verificationId,
    String? phoneNumber,
    bool? buttonEnabled,
    int? seconds,
    bool? timeUp,
    String? userId,
    String? otp,
  }) {
    return OtpState(
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      authMessage: authMessage ?? this.authMessage,
      userData: userData ?? this.userData,
      verificationId: verificationId ?? this.verificationId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      buttonEnabled: buttonEnabled ?? this.buttonEnabled,
      seconds: seconds ?? this.seconds,
      timeUp: timeUp ?? this.timeUp,
      userId: userId ?? this.userId,
      otp: otp ?? this.otp,
    );
  }
}
