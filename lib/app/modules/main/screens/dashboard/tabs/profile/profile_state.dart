part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.profileImage,
    this.countryCode,
    this.flag,
    this.hint,
    this.maxLength,
    this.exampleNumber,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final String? profileImage;
  final String? countryCode;
  final String? flag;
  final String? hint;
  final int? maxLength;
  final String? exampleNumber;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        profileImage,
        countryCode,
        flag,
        hint,
        maxLength,
      ];

  ProfileState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    String? profileImage,
    String? countryCode,
    String? flag,
    String? hint,
    int? maxLength,
    String? exampleNumber,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      profileImage: profileImage ?? this.profileImage,
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      hint: hint ?? this.hint,
      maxLength: maxLength ?? this.maxLength,
      exampleNumber: exampleNumber ?? this.exampleNumber,
    );
  }
}
