import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_search/mapbox_search.dart' as map_box;

import '../../../../../configs/configs.dart';
import '../../../../app.dart';

part 'places_search_state.dart';

class PlacesSearchCubit extends Cubit<PlacesSearchState> {
  PlacesSearchCubit(this.context) : super(const PlacesSearchState()) {
    searchController = TextEditingController();
  }

  final BuildContext context;
  late TextEditingController searchController;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (timer) {
        _performSearch();
        _timer?.cancel();
      },
    );
  }

  void onSubmitted(String text) {
    _performSearch();
  }

  void onChanged(String text) {
    _timer?.cancel();
    _startTimer();
  }

  Future<void> _performSearch() async {
    try {
      emit(
        state.copyWith(
          isSearching: true,
        ),
      );

      var placesSearch = map_box.PlacesSearch(
        apiKey: Constants.mapBoxApiKey,
        limit: 5,
      );

      var placesList = await placesSearch.getPlaces(
        searchController.text,
      );
      if (placesList == null || placesList.isEmpty) {
        // No data found
        emit(
          state.copyWith(
            placesList: [],
          ),
        );
      } else {
        if (state.placesList.isNotEmpty) {
          state.placesList.clear();
        }
        emit(
          state.copyWith(
            placesList: placesList,
          ),
        );
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      emit(
        state.copyWith(
          isSearching: false,
        ),
      );
    }
  }

  void onPlaceTapped(map_box.MapBoxPlace place) {
    if (place.center != null) {
      var lon = place.center![0];
      var lat = place.center![1];
      var name = place.placeName;
      Navigator.pop(
        context,
        {
          PostWorkForms.userLat: '$lat',
          PostWorkForms.userLong: '$lon',
          PostWorkForms.address: name,
        },
      );
    } else {
      Navigator.pop(context, null);
    }
  }
}
