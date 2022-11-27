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
    this.userId,
    this.phoneNumber,
    this.otp,
    this.buttonEnabled = false,
    this.seconds = 60,
    this.timeUp = false,
  });

  final VerifyStatus status;
  final AuthStatus authStatus;
  final String authMessage;
  final String? userId;
  final String? phoneNumber;
  final String? otp;
  final bool buttonEnabled;
  final int seconds;
  final bool timeUp;

  @override
  List<Object?> get props => [
        status,
        authStatus,
        authMessage,
        userId,
        phoneNumber,
        otp,
        buttonEnabled,
        seconds,
        timeUp,
      ];

  OtpState copyWith({
    VerifyStatus? status,
    AuthStatus? authStatus,
    String? authMessage,
    String? userId,
    String? phoneNumber,
    String? otp,
    bool? buttonEnabled,
    int? seconds,
    bool? timeUp,
  }) {
    return OtpState(
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      authMessage: authMessage ?? this.authMessage,
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      buttonEnabled: buttonEnabled ?? this.buttonEnabled,
      seconds: seconds ?? this.seconds,
      timeUp: timeUp ?? this.timeUp,
    );
  }
}
