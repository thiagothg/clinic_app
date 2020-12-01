import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/client/home_client_controller.dart';
import '../../../core/consts/app_conts.dart';
import '../../../models/clinic_model.dart';
import 'widgets/search_bar_widget.dart';

class HomeClientPage extends StatefulWidget {
  final String title;
  const HomeClientPage({Key key, this.title = "HomeClient"}) : super(key: key);

  @override
  _HomeClientPageState createState() => _HomeClientPageState();
}

class _HomeClientPageState
    extends ModularState<HomeClientPage, HomeClientController> {
  //use 'controller' variable to access controller
  
  final LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
 
  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.myKey,
      appBar: AppBar(
        title: Text('Olá ${controller.userStore.userModel.name}'),
        actions: [
          IconButton(
            key: UniqueKey(),
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: (){
              controller.exitApp();
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Observer(
              builder: (context) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialcameraposition
                  ),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  markers: Set<Marker>.of(controller.markers.values),
                  onCameraIdle: () {
                    // updateMap();
                  },
                  onCameraMove: (pos) {
                    controller.cameraPosition = pos;
                  },
                );
              }
            ),

            SearchBarWidget(
              ancestorContext: context,
              refesh: refresh,
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController map) async {
    var loc = await controller.onMapCreated(map);
    setState(() {});
    await _getMarkersLocation(loc);
    setState(() {});
  }

  Future<void> _getMarkersLocation(LocationModel pos) async {
    var clinisNearBy = await controller.clinicRepository
      .getClinicsNearBy(pos)
      .then<Stream<List<ClinicModel>>>((res) => res.object);
    clinisNearBy.listen(_updateMarkers);
  }

  void _updateMarkers(List<ClinicModel> documentList) {
    documentList.forEach(controller.addMarkerClinics);

    setState(() {});
    print(controller.markers);
  }

  Future<void> updateMap() async {
    var latLng = controller.cameraPosition.target;
    print(latLng);
    await controller.updateMap(latLng.latitude, latLng.longitude, '');
    setState(() {});
    
  }

  void refresh() {
    print('refresh');
     setState(() {});
  }
}
