part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profileImage,
    this.countryCode,
    this.flag,
    this.hint,
    this.maxLength,
    this.exampleNumber,
  });

  final String? profileImage;
  final String? countryCode;
  final String? flag;
  final String? hint;
  final int? maxLength;
  final String? exampleNumber;

  @override
  List<Object?> get props => [
        profileImage,
        countryCode,
        flag,
        hint,
        maxLength,
      ];

  ProfileState copyWith({
    String? profileImage,
    String? countryCode,
    String? flag,
    String? hint,
    int? maxLength,
    String? exampleNumber,
  }) {
    return ProfileState(
      profileImage: profileImage ?? this.profileImage,
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      hint: hint ?? this.hint,
      maxLength: maxLength ?? this.maxLength,
      exampleNumber: exampleNumber ?? this.exampleNumber,
    );
  }
}
