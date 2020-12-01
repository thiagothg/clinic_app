import 'package:clinic_app/app/controllers/atendente_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchBarPopUp extends StatefulWidget {

  @override
  _SearchBarPopUpState createState() => _SearchBarPopUpState();
}

class _SearchBarPopUpState extends ModularState<SearchBarPopUp, AtendenteController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String text) {
        controller.setFetchClinicaPopUpCondition(text);
        print(controller.fetchClinicaPopUpCondition);
        setState(() {
          
        });
      },
      // controller: controller.searchTextController,
      initialValue: controller.fetchClinicaPopUpCondition,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        labelText: 'Procurar Clínica',
      ),
    );
  }
}