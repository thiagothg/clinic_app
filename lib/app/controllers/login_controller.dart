import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../core/consts/app_conts.dart';
import '../core/consts/routers_const.dart';
import '../core/enums/access_profile.dart';
import '../interface/auth_repository_interface.dart';
import '../models/user_model.dart';
import '../repositories/local_storage.dart';
import '../repositories/user_repository.dart';
import '../shared/stores/user_store.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UserStore userStore = Modular.get<UserStore>();
  final UserRepository userRepository = Modular.get();
  IAuthRepository authRepository;
  
  _LoginControllerBase() {
    usuario = "";
    password = "";
    authRepository = Modular.get<IAuthRepository>();
  }

  @observable
  String usuario = "";

  // ignore: use_setters_to_change_properties
  @action
  void setUsuario(String value) => usuario = value;

  @observable
  String password = "";

  // ignore: use_setters_to_change_properties
  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @computed
  bool get isPasswordValid => password.length >= 4;

  @computed
  bool get isUsuarioValid => usuario.length >= 4;

  @computed
  Function get loginPressed =>
      (isUsuarioValid && isPasswordValid && !loading) ? login : null;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(milliseconds: 2000));

    await getUser();
    loading = false;
  }

  getUser() async {
    var user = UserModel.userList().firstWhere((e) 
      => e.usuario == usuario.trim() && 
        e.password.trim() == password, orElse: () => null);

    if(user != null) {
      userStore.userModel = user;
      final localStorage = LocalStorage();
        await localStorage.add(
        key: LocalStorageConstants.user,
        value: user.usuario,
      );
      await localStorage.add(
        key: LocalStorageConstants.userPassword,
        value: user.password,
      );
      await authRepository.signIn();
      var screen = RoutersConst.homeScreen;
      if(user.accessProfile == AccessProfile.Administrador) {
        screen = RoutersConst.homeScreen;
      } else if (user.accessProfile == AccessProfile.Atendente) {
        screen = RoutersConst.atendenteHomeScreen;
      } else {
        screen = RoutersConst.clientHomeScreen;
      }

      Modular.to.pushNamedAndRemoveUntil(screen, 
        (route) => false);
    } else {
      var result = await userRepository.filter()
        .where('login', isEqualTo: usuario.trim())
        .where('senha', isEqualTo: password.trim())
        .limit(1)
        .get();

      if(result.docs.isNotEmpty) {
        var doc = result.docs.first;
        var user = UserModel.fromMap(doc);

        userStore.userModel = user;
        final localStorage = LocalStorage();
          await localStorage.add(
          key: LocalStorageConstants.user,
          value: user.usuario,
        );
        await localStorage.add(
          key: LocalStorageConstants.userPassword,
          value: user.password,
        );
        await authRepository.signIn();

        Modular.to.pushNamedAndRemoveUntil(RoutersConst.atendenteHomeScreen, 
          (route) => false);
      } else {
        Fluttertoast.showToast(
          msg: "Usuário ou senha incorretos. Por favor tente novamente!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.redAccent
        );
      }
    }
  }

  @action
  Future<void> logout() async {
    loggedIn = false;

    await _deleteUserFromLocalStorage();
    await authRepository.signOut();
    Modular.to.pushNamedAndRemoveUntil(
        RoutersConst.loginScreen, (route) => false);
  }

  _deleteUserFromLocalStorage() async {
    final localStorage = LocalStorage();

    await localStorage.delete(key: LocalStorageConstants.user);
    await localStorage.delete(key: LocalStorageConstants.userPassword);
  }
}
