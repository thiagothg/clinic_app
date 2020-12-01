import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/splash_controller.dart';
import '../repositories/user_repository.dart';
import '../views/splash/splash_page.dart';



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
