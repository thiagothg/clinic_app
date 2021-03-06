import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/responses/response_builder.dart';
import '../core/responses/response_defult.dart';
import '../interface/firebase_repository_base_interface.dart';
import '../models/base_model.dart';


class FirebaseRepositoyBase<Model extends BaseModel>
    implements IFirebaseRepositoryBaseInterface<Model> {

  FirebaseRepositoyBase({this.fromMap, this.collection}) {
    collection ?? '${Model.toString().toLowerCase()}s';
    collectionReference = FirebaseFirestore.instance.collection(collection);
    firestore = FirebaseFirestore.instance;
  }

  final Model Function(DocumentSnapshot document) fromMap;

  String collection;
  CollectionReference collectionReference;
  FirebaseFirestore firestore;

  @override
  Future<DefaultResponse> add(Model model) async {
    try {
      model.setCreateTime();
      model.setUpdateTime();
      var collection = collectionReference;
      var document = await collection.add(model.toMap());

      return ResponseBuilder.success<String>(
          object: document.id);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }
  
  @override
  Future<DefaultResponse> delete(String documentId) async {
    try {
      var collection = collectionReference;
      await collection.doc(documentId).delete();

      return ResponseBuilder.success();
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }
  
  @override
  Future<DefaultResponse> disable(Model model) async {
    try {
      model.disableDocument();
      var object = update(model);
      return ResponseBuilder.success(
          object: object);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> enable(Model model) async {
    try {
      model.enableDocument();
      update(model);

      return ResponseBuilder.success();
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> getAll() async {
    try {
      var collection = collectionReference;
      var list = <Model>[];
      var querySnapshot = await collection.get();
      for (var element in await querySnapshot.docs) {
        list.add(fromMap(element));
      }
      return await ResponseBuilder.success<List<Model>>(
          object: list);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> getById(String documentId) async {
    try {
      var collection = collectionReference;
      var snapshot = await collection.doc(documentId).get();
      var user;

      if(snapshot.exists) {
        user = fromMap(snapshot);
      }

      return await ResponseBuilder.success<Model>(
          object: user);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> update(Model model) async {
    try {
      model.setUpdateTime();
      var collection = collectionReference;
      await collection
        .doc(model.documentId()).update(model.toMap());

      return await ResponseBuilder.success();
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  @override
  CollectionReference filter() {
   return collectionReference;
  }

  @override
  List<Model> fromSnapshotToModelList(List<DocumentSnapshot> documentList) {
    var list = <Model>[];
    for (var item in documentList) {
      list.add(fromMap(item));
    }
  
    return list;
  }
  
  @override
  Model fromSnapshotToModel(DocumentSnapshot document) {
    return fromMap(document);
  }
      
}