import 'package:clinic_app/app/interface/auth_repository_interface.dart';
import 'package:clinic_app/app/shared/widgets/global_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/responses/response_builder.dart';
import '../core/responses/response_defult.dart';


class AuthRepository implements IAuthRepository {
  FirebaseAuth firebaseAuth;
  
  User user;

  AuthRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<DefaultResponse> signIn() async {
    try {
      await firebaseAuth.signInAnonymously();

      await Future.delayed(Duration(seconds: 5));
      return await ResponseBuilder.success<String>(
          object: 'signInAnonymously');
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  void showSnackBar({
    @required String text, 
    @required Color background}) {

    final snackBar = SnackBar(
      backgroundColor: background,
      content: Text(text,
        textAlign: TextAlign.center,
      ),
    );

    GlobalScaffold.instance.showSnackbar(snackBar);
  }
  
  Future<DefaultResponse> getCurrentUser() async {
    try {
      user = await FirebaseAuth.instance.currentUser;

      return ResponseBuilder.success<User>(
          object: user);
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> signOut() async {
    try {
     await FirebaseAuth.instance.signOut();

      return ResponseBuilder.success<String>(
          object: 'signOut successs');
    } on Exception catch (e) {
      return ResponseBuilder.failed(object: e, message: e.toString());
    }
  }
}