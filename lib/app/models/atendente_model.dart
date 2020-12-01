
import 'package:clinic_app/app/core/enums/access_profile.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';


class AtendenteModel extends BaseModel {
  String name;
  String phone;
  String login;
  String senha;
  String clinic;
  ClinicModel clinicModel;
  AccessProfile accessProfile;

  @override
  AtendenteModel({
    this.name,
    this.phone,
    this.login,
    this.senha,
    this.clinic,
    this.clinicModel,
    this.accessProfile
  });


  AtendenteModel.fromMap(DocumentSnapshot document) : super.fromMap(document) {
    name = document.data()["name"];
    phone = document.data()['phone'];
    login = document.data()['login'];
    senha = document.data()['senha'];
    clinic = document.data()['clinic'];

    accessProfile = getUserProfile('ATENDENTE');
  }

  @override
  Map toMap() {
    var map = super.toMap();
    map['name'] = name;
    map['phone'] = phone;
    map['senha'] = senha;
    map['login'] = login;
    map['clinic'] = clinic;
    
    map['id_perfil_acesso'] = 'ATENDENTE';
    return map;
  }

  setClinic(ClinicModel value) => clinicModel = value;

  static AccessProfile getUserProfile(String accessProfile) {
    switch (accessProfile) {
      case 'ADMINISTRADOR':
        return AccessProfile.Administrador;
        break;
      case 'ATENDENTE':
        return AccessProfile.Atendente;
        break;
      case 'CLIENTE':
        return AccessProfile.Cliente;
        break;
    }

    return AccessProfile.Administrador;
  }
}
