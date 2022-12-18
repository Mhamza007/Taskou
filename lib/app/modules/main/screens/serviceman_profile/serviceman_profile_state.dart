part of 'serviceman_profile_cubit.dart';

class ServicemanProfileState extends Equatable {
  const ServicemanProfileState({
    this.title = '',
    this.browseServiceData,
  });

  final String title;
  final BrowseServiceData? browseServiceData;

  @override
  List<Object?> get props => [
        title,
        browseServiceData,
      ];

  ServicemanProfileState copyWith({
    String? title,
    BrowseServiceData? browseServiceData,
  }) {
    return ServicemanProfileState(
      title: title ?? this.title,
      browseServiceData: browseServiceData ?? this.browseServiceData,
    );
  }
}
