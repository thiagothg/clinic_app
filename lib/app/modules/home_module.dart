import 'package:clinic_app/app/controllers/login_controller.dart';
import 'package:clinic_app/app/views/home/home_page.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';



class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    $HomeController,
    $LoginController,
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
    
  ];

  static Inject get to => Inject<HomeModule>.of();
}
