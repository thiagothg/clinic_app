import 'package:mobx/mobx.dart';
import '../../models/user_model.dart';

part 'user_store.g.dart';

class UserStore = _User with _$UserStore;

abstract class _User with Store {
  @observable
  UserModel userModel;

  

}
