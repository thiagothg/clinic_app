import 'package:clinic_app/app/core/consts/routers_const.dart';
import 'package:clinic_app/app/repositories/atendente_repository.dart';
import 'package:clinic_app/app/repositories/clinic_repository.dart';
import 'package:clinic_app/app/views/clinic/clinic_page.dart';
import 'package:clinic_app/app/views/clinic/pages/add_clinic.dart';
import 'package:clinic_app/app/views/clinic/pages/edit_clinic.dart';
import 'package:clinic_app/app/views/clinic/pages/view_clinic.dart';

import '../controllers/clinic_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';



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
    ModularRouter(RoutersConst.addClinicScreen, child: (_, args) => AddClinicPage()),
    ModularRouter('${RoutersConst.editClinicScreen}/:id', child: (_, args) => EditClinicPage(id: args.params['id'],)),
    ModularRouter('${RoutersConst.viewClinicScreen}/:id', child: (_, args) => ViewClinicPage(id: args.params['id'],)),
  ];

  static Inject get to => Inject<ClinicModule>.of();
}
