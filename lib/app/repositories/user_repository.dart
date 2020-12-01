

import 'package:clinic_app/app/models/atendente_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_repository_base.dart';


class UserRepository extends FirebaseRepositoyBase<AtendenteModel> {

  @override
  String get collection => 'atendente';

  String get collectionClinic => 'clinic';


  @override
  AtendenteModel Function(DocumentSnapshot document)
    get fromMap => (document) => AtendenteModel.fromMap(document);


  
}