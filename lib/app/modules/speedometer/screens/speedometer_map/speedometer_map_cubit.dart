// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../sdk/sdk.dart';

part 'speedometer_map_state.dart';

class SpeedometerMapCubit extends Cubit<SpeedometerMapState> {
  SpeedometerMapCubit(
    this.context, {
    required this.data,
  }) : super(const SpeedometerMapState()) {
    _firebaseDatabase = FirebaseDatabase.instance;

    _getTrackingMode();
  }

  final BuildContext context;
  final Map<String, dynamic> data;
  Completer<GoogleMapController> googleMapcompleter = Completer();
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  TrackingMode? trackingMode;
  late FirebaseDatabase _firebaseDatabase;
  late DatabaseReference _databaseReference;

  void _getTrackingMode() {
    trackingMode = data['mode'];
    emit(
      state.copyWith(
        trackingMode: trackingMode,
      ),
    );

    if (trackingMode == TrackingMode.childMode) {
      ChildModeData childModeData = data['data'];
      emit(
        state.copyWith(
          childModeData: childModeData,
        ),
      );
      _databaseReference = _firebaseDatabase.ref(
        'tracking/${childModeData.code}',
      );
    } else if (trackingMode == TrackingMode.relativeMode) {
      TrackingResponseData trackingResponseData = data['data'];
      emit(
        state.copyWith(
          trackingResponseData: trackingResponseData,
        ),
      );
      _databaseReference = _firebaseDatabase.ref(
        'tracking/${trackingResponseData.code}',
      );
    }
  }

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

  Future<void> _startLocationService() async {
    await _location.changeNotificationOptions(
      title: 'Taskou',
      subtitle: 'Taskou is listening location in background',
    );
    await _location.changeSettings(
      interval: 5000,
    );
    _locationSubscription = _location.onLocationChanged.listen(
      (LocationData event) {
        emit(
          state.copyWith(
            locationData: event,
            speed:
                event.speed != null ? event.speed!.toStringAsFixed(2) : '0.0',
          ),
        );
        uploadLocationDateToFirebase(event);
        debugPrint(
          'Location: Latitude ${event.latitude} Longitude ${event.longitude}',
        );
      },
      onError: (error) => debugPrint(
        'Location: error fetching $error',
      ),
    );
  }

  Future<void> uploadLocationDateToFirebase(LocationData locationData) async {
    try {
      await _databaseReference.set(
        {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
          'accuracy': locationData.accuracy,
          'altitude': locationData.altitude,
          'speed': locationData.speed,
          'speed_accuracy': locationData.speedAccuracy,
          'heading': locationData.heading,
          'time': locationData.time,
          'isMock': locationData.isMock,
          'verticalAccuracy': locationData.verticalAccuracy,
          'headingAccuracy': locationData.headingAccuracy,
          'elapsedRealtimeNanos': locationData.elapsedRealtimeNanos,
          'elapsedRealtimeUncertaintyNanos':
              locationData.elapsedRealtimeUncertaintyNanos,
          'satelliteNumber': locationData.satelliteNumber,
          'provider': locationData.provider,
        },
      );
    } catch (e) {
      debugPrint(
        'Location: uploadLocationDateToFirebase $e',
      );
    }
  }

  Future<void> stopLocationService() async {
    await _location.enableBackgroundMode(enable: false);
    await _locationSubscription?.cancel();
    Navigator.pop(context);
  }

  Future<void> _trackChildLocation() async {}

  Future<void> goToCurrentLocation() async {
    var locationData = await getCurrentLocation();
    if (locationData != null) {
      if (trackingMode == TrackingMode.childMode) {
        _startLocationService();
      } else if (trackingMode == TrackingMode.relativeMode) {
        _trackChildLocation();
      }
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
          if (trackingMode == TrackingMode.childMode) {
            var bgMode = await _location.enableBackgroundMode();
            if (bgMode) {
              locationData = await _location.getLocation();
            } else {
              getCurrentLocation();
            }
          } else if (trackingMode == TrackingMode.relativeMode) {
            locationData = await _location.getLocation();
          }
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
