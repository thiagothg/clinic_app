import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/clinic_controller.dart';
import '../core/consts/routers_const.dart';
import '../repositories/atendente_repository.dart';
import '../repositories/clinic_repository.dart';
import '../views/clinic/clinic_page.dart';
import '../views/clinic/pages/add_clinic.dart';
import '../views/clinic/pages/edit_clinic.dart';
import '../views/clinic/pages/view_clinic.dart';



class ClinicModule extends ChildModule {
  @override
  List<Bind> get binds => [
    $ClinicController,
    Bind((i) => ClinicRepository()),
    Bind((i) => AtendenteRepository()),

  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, args) => ClinicPage()),
    ModularRouter(RoutersConst.addClinicScreen, 
      child: (_, args) => AddClinicPage()),
    ModularRouter('${RoutersConst.editClinicScreen}/:id', 
      child: (_, args) => EditClinicPage(id: args.params['id'],)),
    ModularRouter('${RoutersConst.viewClinicScreen}/:id', 
      child: (_, args) => ViewClinicPage(id: args.params['id'],)),
  ];

  static Inject get to => Inject<ClinicModule>.of();
}
