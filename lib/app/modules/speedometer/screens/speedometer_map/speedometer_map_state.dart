part of 'speedometer_map_cubit.dart';

enum TrackingMode {
  childMode,
  relativeMode,
}

class SpeedometerMapState extends Equatable {
  const SpeedometerMapState({
    this.initialCameraPosition = const CameraPosition(target: LatLng(0, 0)),
    this.googleMapController,
    this.zoom = 15.0,
    this.trackingMode,
    this.childModeData,
    this.trackingResponseData,
    this.speed,
    this.locationData,
  });

  final CameraPosition initialCameraPosition;
  final GoogleMapController? googleMapController;
  final double zoom;
  final TrackingMode? trackingMode;
  final ChildModeData? childModeData;
  final TrackingResponseData? trackingResponseData;
  final String? speed;
  final LocationData? locationData;

  @override
  List<Object?> get props => [
        initialCameraPosition,
        googleMapController,
        zoom,
        trackingMode,
        childModeData,
        trackingResponseData,
        speed,
        locationData,
      ];

  SpeedometerMapState copyWith({
    CameraPosition? initialCameraPosition,
    GoogleMapController? googleMapController,
    double? zoom,
    TrackingMode? trackingMode,
    ChildModeData? childModeData,
    TrackingResponseData? trackingResponseData,
    String? speed,
    LocationData? locationData,
  }) {
    return SpeedometerMapState(
      initialCameraPosition: initialCameraPosition ?? this.initialCameraPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      zoom: zoom ?? this.zoom,
      trackingMode: trackingMode ?? this.trackingMode,
      childModeData: childModeData ?? this.childModeData,
      trackingResponseData: trackingResponseData ?? this.trackingResponseData,
      speed: speed ?? this.speed,
      locationData: locationData ?? this.locationData,
    );
  }
}
