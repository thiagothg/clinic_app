import 'package:flutter_modular/flutter_modular.dart';

import '../../controllers/client/home_client_controller.dart';
import '../../controllers/login_controller.dart';
import '../../repositories/clinic_repository.dart';
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
