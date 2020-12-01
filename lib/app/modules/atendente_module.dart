import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/atendente_controller.dart';
import '../core/consts/routers_const.dart';
import '../repositories/atendente_repository.dart';
import '../repositories/clinic_repository.dart';
import '../views/atendente/atendente_page.dart';
import '../views/atendente/pages/add_atendente_page.dart';
import '../views/atendente/pages/edit_atendente_page.dart';
import '../views/atendente/pages/view_atendente_page.dart';



class AtendenteModule extends ChildModule {
  @override
  List<Bind> get binds => [
    $AtendenteController,
    Bind((i) => AtendenteRepository()),
    Bind((i) => ClinicRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute,
        child: (_, args) => AtendentePage()),
    ModularRouter(RoutersConst.addAtendenteScreen, 
    child: (_, args) => AddAtendentePage()),
    ModularRouter('${RoutersConst.editClinicScreen}/:id', 
      child: (_, args) => EditAtendentePage(id: args.params['id'],)),
    ModularRouter('${RoutersConst.viewClinicScreen}/:id', 
      child: (_, args) => ViewAtendentePage(id: args.params['id'],)),
  ];

  static Inject get to => Inject<AtendenteModule>.of();
}
