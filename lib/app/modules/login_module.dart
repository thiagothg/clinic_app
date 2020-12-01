import 'package:clinic_app/app/repositories/user_repository.dart';

import '../controllers/login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../views/login/login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
    $LoginController,
    Bind((i) => UserRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LoginPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
