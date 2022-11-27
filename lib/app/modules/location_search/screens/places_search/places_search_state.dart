part of 'places_search_cubit.dart';

class PlacesSearchState extends Equatable {
  const PlacesSearchState({
    this.placesList = const [],
    this.isSearching = false,
  });

  final List<map_box.MapBoxPlace> placesList;
  final bool isSearching;

  @override
  List<Object?> get props => [
        placesList,
        isSearching,
      ];

  PlacesSearchState copyWith({
    List<map_box.MapBoxPlace>? placesList,
    bool? isSearching,
  }) {
    return PlacesSearchState(
      placesList: placesList ?? this.placesList,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
