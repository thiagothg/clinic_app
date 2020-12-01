import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/base_model_interface.dart';

class BaseModel implements IBaseModelInterface {
  String id;
  bool isActive = true;
  Timestamp createdAt;
  Timestamp updatedAt;

  BaseModel();

  @override
  BaseModel.fromMap(DocumentSnapshot document) {
    id = document.id;
    isActive = document.data().containsKey('isActive') 
      ? document.data()['isActive'] : false;
    createdAt = document.data().containsKey('createdAt') 
      ? document.data()["createdAt"] : Timestamp.now();
    updatedAt = document.data().containsKey('updatedAt')  
      ? document.data()["updatedAt"]: Timestamp.now();
  }

  @override
  Map toMap() {
    var map = <String, dynamic>{};
    map['isActive'] = isActive;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;

    return map;
  }

  @override
  String documentId() => id;

  @override
  void disableDocument() => isActive = false;

  @override
  void enableDocument() => isActive = true;

  @override
  void setCreateTime() => createdAt = Timestamp.now();

  @override
  void setUpdateTime() => updatedAt = Timestamp.now();

  @override
  void setDocumentId(String value) => id = value;

  @override
  void enable(value) => isActive = value;

  @override
  Timestamp getUpdateTime() => updatedAt;

  @override
  Timestamp getCreateTime() => createdAt;
}