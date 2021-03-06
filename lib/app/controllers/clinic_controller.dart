
import 'package:clinic_app/app/core/consts/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

import '../core/consts/app_conts.dart';
import '../core/consts/routers_const.dart';
import '../core/enums/app_enums.dart';
import '../models/atendente_model.dart';
import '../models/clinic_model.dart';
import '../repositories/atendente_repository.dart';
import '../repositories/clinic_repository.dart';
import '../shared/widgets/lock_screen.dart';
import '../shared/widgets/message_dialog.dart';
import '../shared/widgets/unlock_screen.dart';

part 'clinic_controller.g.dart';

@Injectable()
class ClinicController = _ClinicControllerBase with _$ClinicController;

abstract class _ClinicControllerBase with Store {

  final ClinicRepository clinicRepository = Modular.get();
  final AtendenteRepository atendenteRepository = Modular.get();


  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  BuildContext contextGlobal;

  @observable
  Geoflutterfire geo = Geoflutterfire();

  @observable 
  bool isLoading = false;

  var places = GoogleMapsPlaces(apiKey: ConstsApp.apiKeyGooglePlaces);

  @computed
  Function get editPressed => (!isLoading) ? onTapEdit : null;

  @computed
  Function get savePressed => (!isLoading) ? onTapSave : null;
  
  var nameTextController = TextEditingController();
  var phoneTextController = MaskedTextController(mask: '(00) 0000-0000');
  var cnpfTextController = MaskedTextController(mask: '00.000.000/0000-00');
  var enderecoController = TextEditingController();

  @observable
  PlacesDetailsResponse endDetail;

  @observable 
  ClinicModel clinicModel;

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

  @action
  onTapSave() async {
    print(formKey);
    if (formKey.currentState.validate()) {
      lockScreen(contextGlobal, text: 'Salvando...');
      var point = geo.point(
        latitude: endDetail.result.geometry.location.lat, 
        longitude: endDetail.result.geometry.location.lng
      );
      var clinic = ClinicModel(
        name: nameTextController.text.trim(),
        cnpj: cnpfTextController.text.trim(),
        phone: phoneTextController.text.trim(),
        end: enderecoController.text.trim(),
        location: point
      );

      var result = await clinicRepository.add(clinic);
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
      var point = geo.point(
        latitude: endDetail?.result?.geometry?.location?.lat, 
        longitude: endDetail?.result?.geometry?.location?.lng
      );
      var clinic = ClinicModel(
        name: nameTextController.text.trim(),
        cnpj: cnpfTextController.text.trim(),
        phone: phoneTextController.text.trim(),
        end: enderecoController.text.trim(),
        location: (point.latitude != null 
          && point.longitude != null) ? point : clinicModel.location
      );
      clinic.setDocumentId(clinicModel.id);
      clinic.createdAt = clinicModel.getCreateTime();

      var result = await clinicRepository.update(clinic);
      unlockScreen(contextGlobal);
      if(result.success) {
        successOperation(contextGlobal);
      } else {
        print(result.message);
        _failedOperation(contextGlobal);
      }
    }
  }

  Stream<List<ClinicModel>> getListClinic() async* {
    yield* await clinicRepository.getClinics().then((res) {
      return res.object;
    });
  }

  Future<void> getClinic(String id) async {
    // lockScreen(currentContext, text: 'Carregando...');
    var clinic = await clinicRepository
      .getById(id).then<ClinicModel>((res) => res.object);
    if(clinic != null) {
      nameTextController.text = clinic.name;
      phoneTextController.text = clinic.phone;
      cnpfTextController.text = clinic.cnpj;
      enderecoController.text = clinic.end;
      clinicModel = clinic;
    }
    // unlockScreen(currentContext);
  }

  onTapPopUpMenuItem(
    BuildContext context, {
    @required PopUpMenuOptions selectedMenuItem,
    String idClinic,
  }) {
    switch (selectedMenuItem) {
      case PopUpMenuOptions.deleteItem:
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Excluir Clínica'),
                content: Text('Deseja realmente excluir esta clínica?'),
                actions: [
                  FlatButton(
                    child: Text('Sim'),
                    onPressed: () {
                      Navigator.pop(context);
                      delete(idClinic, context);
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
          Modular.link.pushNamed('${RoutersConst.editClinicScreen}/$idClinic');
        break;
      default:
          Modular.link.pushNamed('${RoutersConst.viewClinicScreen}/$idClinic');
        break;
    }
  }

  delete(String id, BuildContext context) async {
    print(context);
    lockScreen(context, text: 'Excluíndo...');

    var atendente = await atendenteRepository
      .getAtendentesByClinic(id)
      .then<List<AtendenteModel>>((res) => res.object);

    if(atendente.isNotEmpty) {
      unlockScreen(context);
      await Future.delayed(Duration(milliseconds: 200));

      Fluttertoast.showToast(
        msg: 'Não foi possível concluir a operação. '
        'Registro possui relacionametos.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.redAccent
      );
    } else {
      var result = await clinicRepository.delete(id);

      unlockScreen(context);

      if (result.success) {
        await Future.delayed(Duration(milliseconds: 200));
        
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
              await Future.delayed(Duration(milliseconds: 100));
              Navigator.pop(context);

            },
          )
        ]);
  }
}
