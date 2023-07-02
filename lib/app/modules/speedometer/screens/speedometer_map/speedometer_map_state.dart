part of 'speedometer_map_cubit.dart';

enum TrackingMode {
  childMode,
  relativeMode,
  trackHandyman,
}

class SpeedometerMapState extends Equatable {
  const SpeedometerMapState({
    this.loading = true,
    this.message = '',
    this.apiResponseStatus = ApiResponseStatus.none,
    this.initialCameraPosition = const CameraPosition(target: LatLng(0, 0)),
    this.googleMapController,
    this.zoom = 15.0,
    this.trackingMode,
    this.childModeData,
    this.trackingResponseData,
    this.handymanDetails,
    this.speed,
    this.locationData,
    this.markers = const {},
  });

  final bool loading;
  final String message;
  final ApiResponseStatus apiResponseStatus;
  final CameraPosition initialCameraPosition;
  final GoogleMapController? googleMapController;
  final double zoom;
  final TrackingMode? trackingMode;
  final ChildModeData? childModeData;
  final TrackingResponseData? trackingResponseData;
  final HandymanDetails? handymanDetails;
  final String? speed;
  final LocationData? locationData;
  final Set<Marker> markers;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        initialCameraPosition,
        googleMapController,
        zoom,
        trackingMode,
        childModeData,
        trackingResponseData,
        handymanDetails,
        speed,
        locationData,
        markers,
      ];

  SpeedometerMapState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    CameraPosition? initialCameraPosition,
    GoogleMapController? googleMapController,
    double? zoom,
    TrackingMode? trackingMode,
    ChildModeData? childModeData,
    TrackingResponseData? trackingResponseData,
    HandymanDetails? handymanDetails,
    String? speed,
    LocationData? locationData,
    Set<Marker>? markers,
  }) {
    return SpeedometerMapState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      zoom: zoom ?? this.zoom,
      trackingMode: trackingMode ?? this.trackingMode,
      childModeData: childModeData ?? this.childModeData,
      trackingResponseData: trackingResponseData ?? this.trackingResponseData,
      handymanDetails: handymanDetails ?? this.handymanDetails,
      speed: speed ?? this.speed,
      locationData: locationData ?? this.locationData,
      markers: markers ?? this.markers,
    );
  }
}
