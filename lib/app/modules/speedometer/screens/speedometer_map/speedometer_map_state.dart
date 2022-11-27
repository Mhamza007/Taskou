part of 'speedometer_map_cubit.dart';

class SpeedometerMapState extends Equatable {
  const SpeedometerMapState({
    this.initialCameraPosition = const CameraPosition(target: LatLng(0, 0)),
    this.googleMapController,
    this.zoom = 15.0,
  });

  final CameraPosition initialCameraPosition;
  final GoogleMapController? googleMapController;
  final double zoom;

  @override
  List<Object?> get props => [
        initialCameraPosition,
        googleMapController,
        zoom,
      ];

  SpeedometerMapState copyWith({
    CameraPosition? initialCameraPosition,
    GoogleMapController? googleMapController,
    double? zoom,
  }) {
    return SpeedometerMapState(
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      zoom: zoom ?? this.zoom,
    );
  }
}
