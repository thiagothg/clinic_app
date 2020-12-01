import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../shared/stores/user_store.dart';
import 'login_controller.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  LoginController loginController = Modular.get<LoginController>();

  final UserStore userStore = Modular.get<UserStore>();
}
