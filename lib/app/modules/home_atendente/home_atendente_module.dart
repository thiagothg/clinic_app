import 'package:flutter_modular/flutter_modular.dart';

import '../../controllers/atendente/home_atendente_controller.dart';
import '../../controllers/login_controller.dart';
import '../../repositories/atendente_repository.dart';
import '../../repositories/clinic_repository.dart';
import '../../repositories/user_repository.dart';
import '../../views/view_atendente/home_atendente/home_atendente_page.dart';

class HomeAtendenteModule extends ChildModule {
  @override
  List<Bind> get binds => [
    $HomeAtendenteController,
    $LoginController,
    Bind((i) => ClinicRepository()),
    Bind((i) => AtendenteRepository()),
    Bind((i) => UserRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => HomeAtendentePage()),
      ];

  static Inject get to => Inject<HomeAtendenteModule>.of();
}
