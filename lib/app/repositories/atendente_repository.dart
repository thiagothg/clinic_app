
import 'dart:async';

import 'package:clinic_app/app/core/responses/response_builder.dart';
import 'package:clinic_app/app/core/responses/response_defult.dart';
import 'package:clinic_app/app/models/atendente_model.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_repository_base.dart';


class AtendenteRepository extends FirebaseRepositoyBase<AtendenteModel> {

  @override
  String get collection => 'atendente';
  String get collectionClinic => 'clinic';


  @override
  AtendenteModel Function(DocumentSnapshot document)
    get fromMap => (document) => AtendenteModel.fromMap(document);


  Future<DefaultResponse> getAtendentes() async {
    try {
      var result = await firestore
        .collection(collection)
        // .where('users', arrayContains: id)
        .snapshots()
        .asyncMap((groupSnap) => groupsToPairs(groupSnap));

      return ResponseBuilder.success<Stream>(
          object: result);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  Future<List<AtendenteModel>> groupsToPairs(QuerySnapshot groupSnap) {
    return Future.wait(groupSnap.docs.map((groupDoc) async {
      return await groupToPair(groupDoc);
    }).toList());
  }

  Future<AtendenteModel> groupToPair(DocumentSnapshot groupDoc) {
    var atentente = fromMap(groupDoc);
    return firestore
      .collection(collectionClinic)
      .doc(atentente.clinic)
      .get()
      .then((doc) {
        print(doc);
        var clinic = ClinicModel();

        if(doc.exists) {
          clinic = ClinicModel.fromMap(doc);
        }

        atentente.setClinic(clinic);

      return atentente;
    });
  }
  
  Future<DefaultResponse> getAtendentesByClinic(String id) async {
    try {
      var result = await firestore
        .collection(collection)
        .where('clinic', isEqualTo: id)
        .get()
        .then((res) {
          print(res);
          return res.docs.map<AtendenteModel>((e) => AtendenteModel.fromMap(e)).toList();
        });
        

      return ResponseBuilder.success<List<AtendenteModel>>(
          object: result);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }
}