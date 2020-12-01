import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/core/consts/routers_const.dart';
import 'package:clinic_app/app/core/enums/access_profile.dart';
import 'package:clinic_app/app/interface/auth_repository_interface.dart';
import 'package:clinic_app/app/models/user_model.dart';
import 'package:clinic_app/app/repositories/local_storage.dart';
import 'package:clinic_app/app/repositories/user_repository.dart';
import 'package:clinic_app/app/shared/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  @action
  void setUsuario(String value) => usuario = value;

  @observable
  String password = "";

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
      => e.usuario == usuario.trim() && e.password.trim() == password, orElse: () => null);

    if(user != null) {
      userStore.userModel = user;
      final LocalStorage localStorage = LocalStorage();
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

      Modular.to.pushNamedAndRemoveUntil(screen, (Route<dynamic> route) => false);
    } else {
      var result = await userRepository.filter()
        .where('login', isEqualTo: usuario.trim())
        .where('senha', isEqualTo: password.trim())
        .limit(1)
        .get();

      if(result.docs.length > 0) {
        var doc = result.docs.first;
        var user = UserModel.fromMap(doc);

        userStore.userModel = user;
        final LocalStorage localStorage = LocalStorage();
          await localStorage.add(
          key: LocalStorageConstants.user,
          value: user.usuario,
        );
        await localStorage.add(
          key: LocalStorageConstants.userPassword,
          value: user.password,
        );
        await authRepository.signIn();

        Modular.to.pushNamedAndRemoveUntil(RoutersConst.atendenteHomeScreen, (Route<dynamic> route) => false);
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
        RoutersConst.loginScreen, (Route<dynamic> route) => false);
  }

  _deleteUserFromLocalStorage() async {
    final LocalStorage localStorage = LocalStorage();

    await localStorage.delete(key: LocalStorageConstants.user);
    await localStorage.delete(key: LocalStorageConstants.userPassword);
  }
}
