import 'dart:async';

import 'package:clinic_app/app/controllers/login_controller.dart';
import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:clinic_app/app/repositories/clinic_repository.dart';
import 'package:clinic_app/app/shared/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_client_controller.g.dart';

@Injectable()
class HomeClientController = _HomeClientControllerBase
    with _$HomeClientController;

abstract class _HomeClientControllerBase with Store implements Disposable {
  final UserStore userStore = Modular.get<UserStore>();
  final LoginController loginController = Modular.get<LoginController>();
  final ClinicRepository clinicRepository = Modular.get();
  var myKey = GlobalKey<ScaffoldState>();

  var searchTextController = TextEditingController();


  @observable 
  GoogleMapController mapController;

  @observable
  Location location = Location();

  @observable
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @observable 
  StreamSubscription markerSubscription;

  @observable 
  CameraPosition cameraPosition;
  
  double zoom = 11;

  exitApp() async {
    loginController.logout();
  }

  @action
  Future<LocationModel> onMapCreated(GoogleMapController _cntlr) async {
    
    mapController = _cntlr;
    
    var loc = await animatedToUser();

    return loc;
  }

  Future<LocationModel> animatedToUser() async {
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: zoom
      )
    ));

    addMarker(
      LocationModel(latitude: pos.latitude, longitude: pos.longitude),
      'My Location',
      ''
    );
    
    var loc = LocationModel(
      latitude: pos.latitude,
      longitude: pos.longitude
    );
    
    return loc;
  }

  @action
  Future<LocationModel> updateMap(double lat, double lng, String description) async {
    markers.clear();
    var pos = await location.getLocation();
    addMarker(
      LocationModel(latitude: pos.latitude, longitude: pos.longitude),
      'My Location',
      ''
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: zoom
      )
    ));

    var loc = LocationModel(
      latitude: lat,
      longitude: lng
    );
    
    return loc;
  }

  Future<void> addMarker(LocationModel pos, String title, String description) async {
    var markerId = MarkerId(pos.latitude.toString() + pos.longitude.toString());
    var _marker = Marker(
      markerId: markerId,
      position: LatLng(pos.latitude, pos.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      infoWindow: InfoWindow(
        title: '$title',
        snippet: '$description',
      )
    );
    markers[markerId] = _marker;
  }

  Future<void> addMarkerClinics(ClinicModel model) async {
    print('CLinic: ${model.name} - lat: ${model.location.latitude} long: ${model.location.longitude}');
    print('Ate: ${model?.atendenteModel?.name}');
    var markerId = MarkerId(model.location.latitude.toString() + model.location.longitude.toString());
    var _marker = Marker(
      markerId: markerId,
      position: LatLng(model.location.latitude, model.location.longitude),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.defaultMarker),
      infoWindow: InfoWindow(
        title: '${model.name} - ${model.phone}',
        snippet: 'Atendente: ${model?.atendenteModel?.name} \n End: ${model.end} ',
        onTap: () {
          print('tap info');
        }
      )
    );
    markers[markerId] = _marker;
  }
 
  dispose() {
    markerSubscription.cancel();
  }

}