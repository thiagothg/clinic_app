import 'package:clinic_app/app/controllers/client/home_client_controller.dart';
import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:clinic_app/app/shared/widgets/global_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class SearchBarWidget extends StatefulWidget {
  final BuildContext ancestorContext;
  final VoidCallback refesh;

  const SearchBarWidget({Key key, this.ancestorContext, this.refesh}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final HomeClientController controller = Modular.get<HomeClientController>();

  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: ConstsApp.apiKeyGooglePlaces);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: UniqueKey(),
      top: 70,
      right: 15,
      left: 15,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          key: UniqueKey(),
          controller: controller.searchTextController,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15, top: 15),
            suffixIcon: IconButton(
              key: UniqueKey(),
              icon: Icon(FontAwesomeIcons.searchLocation), 
              onPressed: null
            )
          ),
          onTap: () async {
            var p = await PlacesAutocomplete.show(
              hint: 'Procurar',
              context: context, 
              apiKey: ConstsApp.apiKeyGooglePlaces,
              language: 'pt',
              mode: Mode.overlay,
              onError: (e) {
                print(e.errorMessage);
                GlobalScaffold.instance.createSnackBar(
                  text: "Error: ${e?.errorMessage}",
                  background: Theme.of(context).errorColor
                ); 
              }
            );

            if(p != null) {
              updateMap(p);
            }
            print(p);
          },
        ),
      ),
    );
  }

  updateMap(Prediction p) async {
    var detail = await places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;
    controller.searchTextController.text = p.description;
    
    var pos = await controller.updateMap(lat, lng, p.description);
    setState(() {});
    await _getMarkersLocation(pos);
    setState(() { });
  }


  Future<void> _getMarkersLocation(LocationModel pos) async {
    var clinisNearBy = await controller.clinicRepository.getClinicsNearBy(pos).then<Stream<List<ClinicModel>>>((res) => res.object);
    clinisNearBy.listen(_updateMarkers);
  }

  void _updateMarkers(List<ClinicModel> documentList) {
    print(documentList);
    print(controller.markers);
    documentList.forEach((ClinicModel model) {
      controller.addMarkerClinics(model);
    });

    setState(() {});
    widget.refesh();
  }
}