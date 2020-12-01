import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:clinic_app/app/repositories/atendente_repository.dart';
import 'package:clinic_app/app/repositories/clinic_repository.dart';
import 'package:clinic_app/app/shared/stores/user_store.dart';
import 'package:clinic_app/app/shared/widgets/lock_screen.dart';
import 'package:clinic_app/app/shared/widgets/message_dialog.dart';
import 'package:clinic_app/app/shared/widgets/unlock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../login_controller.dart';

part 'home_atendente_controller.g.dart';

@Injectable()
class HomeAtendenteController = _HomeAtendenteControllerBase
    with _$HomeAtendenteController;

abstract class _HomeAtendenteControllerBase with Store {
  LoginController loginController = Modular.get<LoginController>();

  final UserStore userStore = Modular.get<UserStore>();

  final ClinicRepository clinicRepository = Modular.get();
  final AtendenteRepository atendenteRepository = Modular.get();

  @observable
  ObservableList<String> sample = <String>[
    'ABERTO',
    'FECHADO',
  ].asObservable();

  @observable
  String dropDownValue = 'ABERTO';

  @action
  setDropDownValue(String value) {
    dropDownValue = value;
  }

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  BuildContext contextGlobal;

  @observable 
  bool isLoading = false;

  @computed
  Function get editPressed => (!isLoading) ? onTapEdit : null;

  @observable 
  ClinicModel clinicModel;
  
  var nameTextController = TextEditingController();
  var phoneTextController = MaskedTextController(mask: '(00) 0000-0000');
  var cnpfTextController = MaskedTextController(mask: '00.000.000/0000-00');
  var enderecoController = TextEditingController();


  @action
  onTapEdit() async {
    if (formKey.currentState.validate()) {
      lockScreen(contextGlobal, text: 'Salvando...');
      
      clinicModel.status = dropDownValue;

      var result = await clinicRepository.updateStatus(clinicModel);
      unlockScreen(contextGlobal);
      if(result.success) {
        successOperation(contextGlobal);
      } else {
        print(result.message);
        _failedOperation(contextGlobal);
      }
    }
  }

  Stream<ClinicModel> getClinic() async* {
    yield* await clinicRepository.getClinicsByAtendente(userStore.userModel.clinic)
      .then((res) => res.object);
  }

  setData(ClinicModel clinic) {
    clinicModel = clinic;
    nameTextController.text = clinic.name;
    phoneTextController.text = clinic.phone;
    cnpfTextController.text = clinic.cnpj;
    enderecoController.text = clinic.end;
    setDropDownValue(clinic.status);
  }

   _failedOperation(BuildContext context) {
    showMessageDialog(context,
        title: 'Erro',
        content:
            'Não foi possível concluir a operação. Tente novamente mais tarde',
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]);
  }

  successOperation(BuildContext context) {
    showMessageDialog(context,
        title: 'Sucesso',
        content: 'Operação concluída com sucesso!',
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ]);
  }
}
