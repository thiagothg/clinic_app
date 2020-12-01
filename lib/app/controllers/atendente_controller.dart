import 'package:clinic_app/app/core/consts/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../core/consts/routers_const.dart';
import '../core/enums/app_enums.dart';
import '../models/atendente_model.dart';
import '../models/clinic_model.dart';
import '../repositories/atendente_repository.dart';
import '../repositories/clinic_repository.dart';
import '../shared/widgets/error_body.dart';
import '../shared/widgets/loading_body.dart';
import '../shared/widgets/lock_screen.dart';
import '../shared/widgets/message_dialog.dart';
import '../shared/widgets/unlock_screen.dart';

part 'atendente_controller.g.dart';

@Injectable()
class AtendenteController = _AtendenteControllerBase with _$AtendenteController;

abstract class _AtendenteControllerBase with Store {
  final AtendenteRepository atendenteRepository = Modular.get();
  final ClinicRepository clinicRepository = Modular.get();

  var nameTextController = TextEditingController();
  var loginTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var clinicTextController = TextEditingController();
  var phoneTextController = MaskedTextController(mask: '(00) 0000-0000');
  var searchTextController = TextEditingController();

  @observable
  var globalScaffoldKey = GlobalKey<ScaffoldState>();


  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  BuildContext contextGlobal;

  @observable 
  bool isLoading = false;

  @computed
  Function get editPressed => (!isLoading) ? onTapEdit : null;

  @computed
  Function get savePressed => (!isLoading) ? onTapSave : null;

  @observable
  String fetchClinicaPopUpCondition = '';

  @observable
  String selectedClinicID;

  @observable
  bool passwordVisible = false;

  @observable 
  AtendenteModel _atendenteModel;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  setFetchClinicaPopUpCondition(String value) {
    fetchClinicaPopUpCondition = value;
  }

  @action
  setSelectedClinicaID(String value) {
    selectedClinicID = value;
  }

  @action
  onTapSave() async {
    print(selectedClinicID);
    if (formKey.currentState.validate()) {
      lockScreen(contextGlobal, text: 'Salvando...');
      var atendimento = AtendenteModel(
        name: nameTextController.text.trim(),
        login: loginTextController.text.trim(),
        phone: phoneTextController.text.trim(),
        senha: passwordTextController.text.trim(),
        clinic: selectedClinicID
      );

      var result = await atendenteRepository.add(atendimento);
      unlockScreen(contextGlobal);
      if(result.success) {
        successOperation(contextGlobal);
      } else {
        print(result.message);
        _failedOperation(contextGlobal);
      }
    }
  }

  @action
  onTapEdit() async {
    if (formKey.currentState.validate()) {
      lockScreen(contextGlobal, text: 'Salvando...');
      var atendimento = AtendenteModel(
        name: nameTextController.text.trim(),
        login: loginTextController.text.trim(),
        phone: phoneTextController.text.trim(),
        senha: passwordTextController.text.trim(),
        clinic: selectedClinicID
      );
      
      atendimento.setDocumentId(_atendenteModel.id);
      atendimento.createdAt = _atendenteModel.createdAt;

      var result = await atendenteRepository.update(atendimento);
      unlockScreen(contextGlobal);
      if(result.success) {
        successOperation(contextGlobal);
      } else {
        print(result.message);
        _failedOperation(contextGlobal);
      }
    }
  }

  Stream<List<AtendenteModel>> getListAtendentes() async* {
    yield* await atendenteRepository.getAtendentes().then((res) {
      return res.object;
    });
  }

  Future<void> getAtendente(String id) async {
    // lockScreen(currentContext, text: 'Carregando...');
    var atendente = await atendenteRepository
      .getById(id)
      .then<AtendenteModel>((res) => res.object);
    
    var clinic = await clinicRepository
      .getById(atendente.clinic)
      .then<ClinicModel>((res) => res.object);

    if(atendente != null) {
      nameTextController.text = atendente.name;
      phoneTextController.text = atendente.phone;
      loginTextController.text = atendente.login;
      clinicTextController.text = clinic?.name;
      selectedClinicID  = atendente.clinic;
      passwordTextController.text = atendente.senha;
      _atendenteModel = atendente;
      _atendenteModel.setClinic(clinic);
    } else {
      showMessageDialog(contextGlobal,
        title: 'Erro',
        content:
            'Não foi possível concluir a operação. Tente novamente mais tarde',
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(contextGlobal);
            },
          )
        ]);
    }
    // unlockScreen(currentContext);
  }

  Stream<List<ClinicModel>> getPopUpListClinic() async* {
    yield* await clinicRepository.getClinicsBy(
        fetchClinicaPopUpCondition.trim()).then((res) {
      return res.object;
    });
  }

  onTapPopUpMenuItem(
    BuildContext context, {
    @required PopUpMenuOptions selectedMenuItem,
    String id,
  }) {
    switch (selectedMenuItem) {
      case PopUpMenuOptions.deleteItem:
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Excluir Atendente'),
                content: Text('Deseja realmente excluir esta atendente?'),
                actions: [
                  FlatButton(
                    child: Text('Sim'),
                    onPressed: () {
                      Navigator.pop(context);
                      delete(id, context);
                    },
                  ),
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
        break;
        case PopUpMenuOptions.editItem:
          Modular.link.pushNamed('${RoutersConst.editAtendenteScreen}/$id');
        break;
      default:
          Modular.link.pushNamed('${RoutersConst.viewAtendenteScreen}/$id');
        break;
    }
  }

  delete(String id, BuildContext context) async{
    lockScreen(context, text: 'Excluíndo...');
    

    var res = await atendenteRepository.delete(id);

    unlockScreen(context);

    if (res.success) {
      Fluttertoast.showToast(
        msg: "Operação concluída com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ColorsConst.background
      );
    } else {
      _failedOperation(context);
    }
  }

  _failedOperation(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Não foi possível concluir a operação. Tente novamente mais tarde!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 8,
      backgroundColor: Colors.redAccent
    );
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
              await Future.delayed(Duration(milliseconds: 200));
              Navigator.pop(context);

            },
          )
        ]);
  }

  fetchClinica(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return alertDialog();
      }
    );
  }

  AlertDialog alertDialog() {
    return AlertDialog(
      content: Column(
        children: [
          // SearchBarPopUp(),
          Divider(
            height: 40,
          ),
          Expanded(
            child: Observer(builder: (_) {
              return StreamBuilder<List<ClinicModel>>(
                stream: getPopUpListClinic(),
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return errorBody();
                      break;
                    case ConnectionState.waiting:
                      return loadingBody();
                      break;
                    default:
                      print(snapshot?.data);
                      if(snapshot?.data?.length != null) {
                        if(snapshot.data.isNotEmpty) {
                          return listViewPopUpMenu(snapshot.data);
                        } else {
                          return emptyBody();
                        }
                      } 
                      return errorBody();
                      break;
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget listViewPopUpMenu(List<ClinicModel> list) {
    return Container(
      height: 400,
      width: 400,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var model = list[index];
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          clinicTextController.text = model.name;
                          setSelectedClinicaID(model.id);
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          title: Text(
                            model.name,
                          ),
                          subtitle: Text(
                              '${model.end} - ${model.cnpj} - ${model.phone}'),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            );
          }),
    );
  }
}
