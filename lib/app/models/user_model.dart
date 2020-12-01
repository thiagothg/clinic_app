import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/enums/access_profile.dart';

class UserModel  {

  final String id;
  final String name;
  final String usuario;
  final String password;
  final AccessProfile accessProfile;
  final bool isAdmin;
  final String clinic;

  UserModel({
    this.id, 
    this.name, 
    this.usuario, 
    this.accessProfile, 
    this.password,
    this.isAdmin,
    this.clinic });


  factory UserModel.fromJson(Map json) {
    return UserModel(
      id: json['id_usuario'], 
      name: json['nome_usuario'], 
    
      isAdmin: (json['id_perfil_acesso'] == "ADMINISTRADOR"),
      accessProfile: getUserProfile(json['id_perfil_acesso'])
    );
  }

  factory UserModel.fromMap(DocumentSnapshot document) {
    return UserModel(
      id: document.id, 
      name: document.data()["name"], 
      usuario: document.data()['login'],
      password: document.data()['senha'],
      isAdmin: (document.data()['id_perfil_acesso'] == "ADMINISTRADOR"),
      accessProfile: getUserProfile(document.data()['id_perfil_acesso']),
      clinic: document.data()['clinic'],
    ); 
  }

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

  static List<UserModel> userList() {
    return <UserModel> [
      UserModel(
        id: '1',
        name: 'Administrador',
        usuario: 'admin',
        password: 'admin',
        accessProfile: AccessProfile.Administrador,
        isAdmin: true
      ),
       UserModel(
        id: '2',
        name: 'Atendente',
        usuario: 'clinic',
        password: 'clinic',
        accessProfile: AccessProfile.Atendente,
        isAdmin: true
      ),
       UserModel(
        id: '3',
        name: 'Cliente',
        usuario: 'client',
        password: 'client',
        accessProfile: AccessProfile.Cliente,
        isAdmin: true
      ),
    ];
  }
}