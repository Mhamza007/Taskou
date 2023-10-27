import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_search/mapbox_search.dart' as map_box;
import 'package:flutter_google_places/flutter_google_places.dart';

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

  void back() => Navigator.pop(context);

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (timer) {
        // _performSearch();
        _timer?.cancel();
      },
    );
  }

  void onSubmitted(String text) {
    // _performSearch();
    predict();
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

      Map<String, dynamic> querys = {
        'input': searchController.text,
        'key': 'AIzaSyDkRtN_gPTXNm_0tWiFJ4AGnMY-jQLpXik',
      };
      final url = Uri.https(
        "maps.googleapis.com",
        "maps/api/place/autocomplete/json",
        querys,
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        response.body;
      } else {
        emit(
          state.copyWith(
            placesList: [],
          ),
        );
      }

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

  Future placeAutoComplete() async {
    try {
      Map<String, dynamic> querys = {
        'input': searchController.text,
        'key': 'AIzaSyDkRtN_gPTXNm_0tWiFJ4AGnMY-jQLpXik',
      };
      final url = Uri.https(
        "maps.googleapis.com",
        "maps/api/place/autocomplete/json",
        querys,
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        response.body;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future predict() async {
    const kGoogleApiKey = "AIzaSyDkRtN_gPTXNm_0tWiFJ4AGnMY-jQLpXik";

    var p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: (e) {},
      mode: Mode.fullscreen,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );

    if (p != null) {
      //   GoogleMapsPlaces _places = GoogleMapsPlaces(
      //     apiKey: kGoogleApiKey,
      //     apiHeaders: await const GoogleApiHeaders().getHeaders(),
      //   );
      //   PlacesDetailsResponse detail =
      //       await _places.getDetailsByPlaceId(p.placeId!);
      //   final lat = detail.result.geometry!.location.lat;
      //   final lng = detail.result.geometry!.location.lng;
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
