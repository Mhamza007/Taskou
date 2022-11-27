import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'speedometer_map_state.dart';

class SpeedometerMapCubit extends Cubit<SpeedometerMapState> {
  SpeedometerMapCubit(
    this.context,
  ) : super(const SpeedometerMapState());

  final BuildContext context;
  Completer<GoogleMapController> googleMapcompleter = Completer();
  final Location _location = Location();

  void onMapCreated(GoogleMapController controller) {
    if (!googleMapcompleter.isCompleted) {
      googleMapcompleter.complete(controller);
    }
    emit(
      state.copyWith(
        googleMapController: controller,
      ),
    );
    goToCurrentLocation();
  }

  Future<void> goToCurrentLocation() async {
    var locationData = await getCurrentLocation();
    if (locationData != null) {
      if (locationData.latitude != null && locationData.longitude != null) {
        state.googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                locationData.latitude!,
                locationData.longitude!,
              ),
              zoom: state.zoom,
            ),
          ),
        );
      } else {
        // Error
      }
    } else {
      // Error
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    LocationData? locationData;
    try {
      var serviceEnabled = await _location.serviceEnabled();
      if (serviceEnabled) {
        var permissionStatus = await _location.hasPermission();
        if (permissionStatus == PermissionStatus.granted) {
          locationData = await _location.getLocation();
        } else {
          await _location.requestPermission();
          getCurrentLocation();
        }
      } else {
        await _location.requestService();
        getCurrentLocation();
      }
    } catch (e) {
      locationData = null;
    }
    return locationData;
  }
}
