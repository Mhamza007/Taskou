// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:taskou/db/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'speedometer_map_state.dart';

class SpeedometerMapCubit extends Cubit<SpeedometerMapState> {
  SpeedometerMapCubit(
    this.context, {
    required this.data,
  }) : super(const SpeedometerMapState()) {
    _firebaseDatabase = FirebaseDatabase.instance;
    _userStorage = UserStorage();
    _bookingsApi = BookingsApi();

    _getTrackingMode();
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late BookingsApi _bookingsApi;
  final Map<String, dynamic> data;
  Completer<GoogleMapController> googleMapcompleter = Completer();
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  StreamSubscription<DatabaseEvent>? _databaseSubscription;
  TrackingMode? trackingMode;
  late FirebaseDatabase _firebaseDatabase;
  late DatabaseReference _databaseReference;

  void back() => Navigator.pop(context);

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
    } else if (trackingMode == TrackingMode.trackHandyman) {
      var handymanId = data['handyman_id'];
      _databaseReference = _firebaseDatabase.ref(
        'tracking/$handymanId',
      );

      getHandymanData(handymanId: handymanId);
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
    if (trackingMode == TrackingMode.relativeMode ||
        trackingMode == TrackingMode.trackHandyman) {
      _trackChildLocation();
    } else {
      goToCurrentLocation();
    }
  }

  Future<void> _startLocationService() async {
    await _location.changeNotificationOptions(
      title: Res.string.appTitle,
      subtitle: Res.string.locationBackgroundNotificationMessage,
    );
    // await _location.changeSettings(
    //   interval: 5000, // 5 seconds
    //   distanceFilter: 5.0, // 5.0 meters
    // );
    _locationSubscription = _location.onLocationChanged.listen(
      (LocationData event) {
        emit(
          state.copyWith(
            locationData: event,
            speed: event.speed != null
                ? '${(event.speed! * 3.6).round()} KM'
                : '0 KM',
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
          'speed': '${locationData.speed}',
          'time': locationData.time,
          'isMock': locationData.isMock,
          'verticalAccuracy': locationData.verticalAccuracy,
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

  Future<void> _trackChildLocation() async {
    try {
      var data = await _databaseReference.get();
      if (data.exists) {
        _databaseSubscription = _databaseReference.onValue.listen(
          (DatabaseEvent event) {
            var data = event.snapshot.value as Map;

            var locationMap = {
              'latitude': data['latitude'],
              'longitude': data['longitude'],
              'accuracy': data['accuracy'],
              'altitude': data['altitude'],
              'speed': double.parse(data['speed']),
              'time': double.parse(data['time'].toString()),
              'isMock': data['isMock'],
              'verticalAccuracy': data['verticalAccuracy'],
              'provider': data['provider'],
            };
            var locationData = LocationData.fromMap(locationMap);

            var infoTitle = '${state.trackingResponseData?.name}';

            String? infoSnippet;
            if (locationData.time != null) {
              var dateTime = DateTime.fromMillisecondsSinceEpoch(
                locationData.time!.toInt(),
              );
              String? lastUpdated = '${dateTime.hour}:${dateTime.minute}';
              infoSnippet = 'Last updated: $lastUpdated';
            }

            emit(
              state.copyWith(
                speed: locationData.speed?.toStringAsFixed(2),
                locationData: locationData,
                markers: {
                  Marker(
                    markerId: MarkerId('${locationData.time}'),
                    infoWindow: InfoWindow(
                      title: infoTitle,
                      snippet: infoSnippet,
                    ),
                    position: LatLng(
                      locationData.latitude!,
                      locationData.longitude!,
                    ),
                  ),
                },
              ),
            );

            if (locationData.latitude != null &&
                locationData.longitude != null) {
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
            }
          },
          onError: (e) {
            debugPrint('_trackChildLocation $e');
          },
        );
      } else {
        // The code does not exists
        Helpers.errorSnackBar(
          context: context,
          title:
              '${state.trackingResponseData?.relation} ${state.trackingResponseData?.name} ${Res.string.notFound}',
        );
      }
    } catch (e) {
      debugPrint('_trackChildLocation $e');
    }
  }

  Future<void> goToCurrentLocation() async {
    var locationData = await getCurrentLocation();
    if (locationData != null) {
      if (locationData.latitude != null && locationData.longitude != null) {
        await state.googleMapController?.animateCamera(
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
        debugPrint('goToCurrentLocation lat lon null');
      }
      if (trackingMode == TrackingMode.childMode) {
        _startLocationService();
      } else if (trackingMode == TrackingMode.relativeMode ||
          trackingMode == TrackingMode.trackHandyman) {
        _trackChildLocation();
      }
    } else {
      // Error
      debugPrint('goToCurrentLocation locationData null');
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

  Future<void> getHandymanData({
    required String handymanId,
  }) async {
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null) {
          var response = await _bookingsApi.getHandymanById(
            userToken: userToken,
            handymanId: handymanId,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                handymanDetails: response?.data?.handymanDetails,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  Future<void> call() async {
    if (state.handymanDetails != null &&
        state.handymanDetails?.countryCode != null &&
        state.handymanDetails?.userMobile != null) {
      await launchUrl(
        Uri.parse(
          'tel:${state.handymanDetails?.countryCode}${state.handymanDetails?.userMobile}',
        ),
      );
    } else {
      Helpers.errorSnackBar(
        context: context,
        title: 'Can not call',
      );
    }
  }

  Future<void> chat() async {
    try {
      var handymanId = data['handyman_id'];
      if (handymanId != null && handymanId != "") {
        String receiverId = handymanId;

        Navigator.pushNamed(
          context,
          Routes.chat,
          arguments: {
            'receiver_id': receiverId,
            'receiver_name':
                '${state.handymanDetails?.firstName} ${state.handymanDetails?.lastName}',
          },
        );
      }
    } catch (e) {
      Helpers.errorSnackBar(
        context: context,
        title: 'Unable to open chat',
      );
    }
  }

  @override
  Future<void> close() {
    _databaseSubscription?.cancel();

    return super.close();
  }
}
