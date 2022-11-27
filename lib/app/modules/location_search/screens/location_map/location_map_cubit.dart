import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_map_state.dart';

class LocationMapCubit extends Cubit<LocationMapState> {
  LocationMapCubit() : super(const LocationMapState()) {
    searchController = TextEditingController();
  }

  late TextEditingController searchController;

  Future<void> performSearch() async {}
}
