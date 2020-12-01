import 'package:clinic_app/app/repositories/user_repository.dart';
import 'package:clinic_app/app/views/splash/splash_page.dart';

import '../controllers/splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';



class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $SplashController,
        Bind((i) => UserRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
