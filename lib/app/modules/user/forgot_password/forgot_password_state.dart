part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.countryCode,
    this.flag,
    this.hint,
    this.maxLength,
    this.examplePhoneNumber,
  });

  final String? countryCode;
  final String? flag;
  final String? hint;
  final int? maxLength;
  final String? examplePhoneNumber;

  ForgotPasswordState copyWith({
    String? countryCode,
    String? flag,
    String? hint,
    int? maxLength,
    String? examplePhoneNumber,
  }) {
    return ForgotPasswordState(
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      hint: hint ?? this.hint,
      maxLength: maxLength ?? this.maxLength,
      examplePhoneNumber: examplePhoneNumber ?? this.examplePhoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        countryCode,
        flag,
        hint,
        maxLength,
      ];
}
