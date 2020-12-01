import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../core/consts/app_conts.dart';
import '../core/consts/routers_const.dart';
import '../core/enums/access_profile.dart';
import '../interface/auth_repository_interface.dart';
import '../models/user_model.dart';
import '../repositories/local_storage.dart';
import '../repositories/user_repository.dart';
import '../shared/stores/user_store.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {

  IAuthRepository authRepository;

  _SplashControllerBase() {
    authRepository = Modular.get<IAuthRepository>();
  }

  final LocalStorage localStorage = LocalStorage();
  final UserStore userStore = Modular.get<UserStore>();
  final UserRepository userRepository = Modular.get();

  @action
  callLoginScreen() async {
    await Future.delayed(Duration(milliseconds: 2800));
    await checkUserLoggedIn();
  }

  checkUserLoggedIn() async {
    await localStorage.init();

    final usuario =
        localStorage.read(key: LocalStorageConstants.user);
    final password =
        localStorage.read(key: LocalStorageConstants.userPassword);

    if(usuario != null && password != null) {

      var user = UserModel.userList().firstWhere((e) 
        => e.usuario == usuario?.trim() 
          && e.password.trim() == password?.trim(), orElse: () => null);

      if(user != null) {
        var screen = RoutersConst.homeScreen;
        
        userStore.userModel = user;
        await authRepository.signIn();
        if(user.accessProfile == AccessProfile.Administrador) {
          screen = RoutersConst.homeScreen;
        } else if (user.accessProfile == AccessProfile.Atendente) {
          screen = RoutersConst.atendenteHomeScreen;
        } else {
          screen = RoutersConst.clientHomeScreen;
        }

        Modular.to.pushNamedAndRemoveUntil(screen, (route) => false);
      } else {

        var result = await userRepository.filter()
          .where('login', isEqualTo: usuario.trim())
          .where('senha', isEqualTo: password.trim())
          .limit(1)
          .get();

        if(result.docs.first.exists) { 
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
        }  else { 
          Modular.to.pushNamedAndRemoveUntil(RoutersConst.loginScreen, 
            (route) => false
          );
        }
      }
    } else {
      Modular.to.pushNamedAndRemoveUntil(RoutersConst.loginScreen, 
        (route) => false
      );
    }
  }
}
