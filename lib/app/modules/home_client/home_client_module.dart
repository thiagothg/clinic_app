import 'package:clinic_app/app/controllers/login_controller.dart';
import 'package:clinic_app/app/repositories/clinic_repository.dart';

import '../../controllers/client/home_client_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../views/client/home/home_client_page.dart';

class HomeClientModule extends ChildModule {
  @override
  List<Bind> get binds => [
    $HomeClientController,
    $LoginController,
    Bind((i) => ClinicRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute,
        child: (_, args) => HomeClientPage()),
  ];

  static Inject get to => Inject<HomeClientModule>.of();
}
