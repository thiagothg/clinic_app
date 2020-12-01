
import 'dart:async';

import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/core/responses/response_builder.dart';
import 'package:clinic_app/app/core/responses/response_defult.dart';
import 'package:clinic_app/app/models/atendente_model.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'firebase_repository_base.dart';


class ClinicRepository extends FirebaseRepositoyBase<ClinicModel> {
  final geo = Geoflutterfire();
  
  @override
  String get collection => 'clinic';
  String get atendenteCollection => 'atendente';

  @override
  ClinicModel Function(DocumentSnapshot document)
    get fromMap => (document) => ClinicModel.fromMap(document);


  Future<DefaultResponse> getClinics() async {
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

  Future<List<ClinicModel>> groupsToPairs(QuerySnapshot groupSnap) {
    return Future.wait(groupSnap.docs.map((groupDoc) async {
      return await groupToPair(groupDoc);
    }).toList());
  }

  Future<ClinicModel> groupToPair(DocumentSnapshot groupDoc) async {
    var clinic = fromMap(groupDoc);
    return await clinic;
  }

  Future<DefaultResponse> getClinicsBy(String condition) async {
    try {
      var result = await firestore
        .collection(collection)
        .where('name', isGreaterThanOrEqualTo: condition)
        .where('name', isLessThan: condition +'z')
        // .get();
        .snapshots()
        .asyncMap((groupSnap) => groupsToPairs(groupSnap));

      return ResponseBuilder.success<Stream>(
          object: result);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  Future<DefaultResponse> getClinicsNearBy(LocationModel pos) async {
    try {
      // var ref = firestore.collection(collection);

      var center = geo.point(
        latitude: pos.latitude, 
        longitude: pos.longitude
      );

      var result = await geo.collection(collectionRef: collectionReference)
      .within(
        center: center, 
        radius: 7, 
        field: 'location',
        strictMode: true
      ).asyncMap((groupSnap) {
        print(groupSnap.length);
        return Future.wait(groupSnap.map((groupDoc) async {
          var model = fromMap(groupDoc);
          return  await firestore.collection(atendenteCollection)
            .where('clinic', isEqualTo: model.id)
            .limit(1)
            .get()
            .then((res) {
              print(res.docs.length);
              if(res.docs.length > 0) {
                model.atendenteModel = AtendenteModel.fromMap(res.docs.first);
              } else {
                model.atendenteModel = AtendenteModel(
                  name: ''
                );
              }

              return model;
            });
        }).toList());
      });

      return ResponseBuilder.success<Stream>(
          object: result);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  Future<DefaultResponse> getClinicsByAtendente(String id) async {
    try {
      
      var result = await firestore
        .collection(collection)
        .doc(id)
        .snapshots()
        .asyncMap((groupSnap) async {
          if(groupSnap.exists) {
            return fromMap(groupSnap);
          }
      });

      return ResponseBuilder.success<Stream>(
          object: result);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  Future<DefaultResponse> updateStatus(ClinicModel model) async {
    try {
      
      model.setUpdateTime();
      var collection = collectionReference;
      await collection
        .doc(model.documentId())
        .update({
          'status': model.status,
          'updatedAt': model.updatedAt
        });

      return ResponseBuilder.success();
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }
  
}