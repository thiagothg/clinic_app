import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'core/consts/routers_const.dart';
import 'interface/auth_repository_interface.dart';
import 'modules/atendente_module.dart';
import 'modules/clinic_module.dart';
import 'modules/home_atendente/home_atendente_module.dart';
import 'modules/home_client/home_client_module.dart';
import 'modules/home_module.dart';
import 'modules/login_module.dart';
import 'modules/splash_module.dart';
import 'repositories/auth_repository.dart';
import 'shared/stores/user_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    $AppController,
    Bind((i) => UserStore()),
    Bind<IAuthRepository>(
      (i) => AuthRepository(),
    ),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, module: SplashModule()),
    ModularRouter(RoutersConst.loginScreen, module: LoginModule()),

    ModularRouter(RoutersConst.clientHomeScreen, module: HomeClientModule()),
    ModularRouter(RoutersConst.homeScreen, module: HomeModule()),
    ModularRouter(RoutersConst.clinicScreen, module: ClinicModule(),
      transition: TransitionType.rightToLeftWithFade
    ),

    ModularRouter(RoutersConst.atendenteScreen, module: AtendenteModule(),
      transition: TransitionType.rightToLeftWithFade
    ),

    ModularRouter(RoutersConst.atendenteHomeScreen, 
      module: HomeAtendenteModule(),
      transition: TransitionType.rightToLeftWithFade
    ),
  ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
