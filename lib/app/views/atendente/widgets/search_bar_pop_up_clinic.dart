import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/atendente_controller.dart';

class SearchBarPopUp extends StatefulWidget {

  @override
  _SearchBarPopUpState createState() => _SearchBarPopUpState();
}

class _SearchBarPopUpState extends 
  ModularState<SearchBarPopUp, AtendenteController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
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