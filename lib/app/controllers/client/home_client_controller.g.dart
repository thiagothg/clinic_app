// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_client_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeClientController = BindInject(
  (i) => HomeClientController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeClientController on _HomeClientControllerBase, Store {
  final _$mapControllerAtom =
      Atom(name: '_HomeClientControllerBase.mapController');

  @override
  GoogleMapController get mapController {
    _$mapControllerAtom.reportRead();
    return super.mapController;
  }

  @override
  set mapController(GoogleMapController value) {
    _$mapControllerAtom.reportWrite(value, super.mapController, () {
      super.mapController = value;
    });
  }

  final _$locationAtom = Atom(name: '_HomeClientControllerBase.location');

  @override
  Location get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Location value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$markersAtom = Atom(name: '_HomeClientControllerBase.markers');

  @override
  Map<MarkerId, Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Map<MarkerId, Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$markerSubscriptionAtom =
      Atom(name: '_HomeClientControllerBase.markerSubscription');

  @override
  StreamSubscription<dynamic> get markerSubscription {
    _$markerSubscriptionAtom.reportRead();
    return super.markerSubscription;
  }

  @override
  set markerSubscription(StreamSubscription<dynamic> value) {
    _$markerSubscriptionAtom.reportWrite(value, super.markerSubscription, () {
      super.markerSubscription = value;
    });
  }

  final _$cameraPositionAtom =
      Atom(name: '_HomeClientControllerBase.cameraPosition');

  @override
  CameraPosition get cameraPosition {
    _$cameraPositionAtom.reportRead();
    return super.cameraPosition;
  }

  @override
  set cameraPosition(CameraPosition value) {
    _$cameraPositionAtom.reportWrite(value, super.cameraPosition, () {
      super.cameraPosition = value;
    });
  }

  final _$onMapCreatedAsyncAction =
      AsyncAction('_HomeClientControllerBase.onMapCreated');

  @override
  Future<LocationModel> onMapCreated(GoogleMapController _cntlr) {
    return _$onMapCreatedAsyncAction.run(() => super.onMapCreated(_cntlr));
  }

  final _$updateMapAsyncAction =
      AsyncAction('_HomeClientControllerBase.updateMap');

  @override
  Future<LocationModel> updateMap(double lat, double lng, String description) {
    return _$updateMapAsyncAction
        .run(() => super.updateMap(lat, lng, description));
  }

  @override
  String toString() {
    return '''
mapController: ${mapController},
location: ${location},
markers: ${markers},
markerSubscription: ${markerSubscription},
cameraPosition: ${cameraPosition}
    ''';
  }
}
