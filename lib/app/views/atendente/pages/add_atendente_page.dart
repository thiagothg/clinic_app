import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/atendente_controller.dart';
import 'form_atendente.dart';

class AddAtendentePage extends StatefulWidget {
  @override
  _AddAtendentePageState createState() => _AddAtendentePageState();
}

class _AddAtendentePageState extends 
  ModularState<AddAtendentePage, AtendenteController> {

  @override
  void initState() { 
    super.initState();
    
    controller.contextGlobal = context;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Atendente',
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormAtendentePage(
          labelButton: 'Salvar',
          buttonPressed: controller.savePressed,
        ),
      )
    );
  }
}