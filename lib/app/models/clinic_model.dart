
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'atendente_model.dart';
import 'base_model.dart';


class ClinicModel extends BaseModel {
  String name;
  String cnpj;
  String phone;
  String end;
  GeoFirePoint location;
  String status;
  AtendenteModel atendenteModel;

  @override
  ClinicModel({
    this.name,
    this.cnpj,
    this.phone,
    this.end,
    this.location,
    this.status,
    this.atendenteModel
  });

  ClinicModel.fromMap(DocumentSnapshot document) : super.fromMap(document) {
    name = document.data()["name"];
    cnpj = document.data()['cnpj'];
    phone = document.data()['phone'];
    end = document.data()['end'];

    var loc = document?.data()['location'];
    if(loc != null) {
      final GeoPoint point = document?.data()['location']['geopoint'];
      var geo = GeoFirePoint(
        point.latitude,
        point.longitude
      );
      
      location = geo;
    }

    status = document?.data()['status'] ?? 'FECHADO';
  }

  @override
  Map toMap() {
    var map = super.toMap();
    map['name'] = name;
    map['cnpj'] = cnpj;
    map['phone'] = phone;
    map['end'] = end;
    map['location'] = location?.data;
    map['status'] = status;

    return map;
  }
}
