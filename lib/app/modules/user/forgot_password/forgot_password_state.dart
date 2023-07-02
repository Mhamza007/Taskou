part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.countryCode,
    this.flag,
    this.hint,
    this.maxLength,
    this.examplePhoneNumber,
    this.status = VerifyStatus.loaded,
    this.authStatus = AuthStatus.none,
    this.authMessage = '',
    this.verificationId,
  });

  final String? countryCode;
  final String? flag;
  final String? hint;
  final int? maxLength;
  final String? examplePhoneNumber;
  final VerifyStatus status;
  final AuthStatus authStatus;
  final String authMessage;
  final String? verificationId;

  @override
  List<Object?> get props => [
        countryCode,
        flag,
        hint,
        maxLength,
        status,
        authStatus,
        authMessage,
        verificationId,
      ];

  ForgotPasswordState copyWith({
    String? countryCode,
    String? flag,
    String? hint,
    int? maxLength,
    String? examplePhoneNumber,
    VerifyStatus? status,
    AuthStatus? authStatus,
    String? authMessage,
    String? verificationId,
  }) {
    return ForgotPasswordState(
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      hint: hint ?? this.hint,
      maxLength: maxLength ?? this.maxLength,
      examplePhoneNumber: examplePhoneNumber ?? this.examplePhoneNumber,
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      authMessage: authMessage ?? this.authMessage,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}
