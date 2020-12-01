import 'package:clinic_app/app/controllers/atendente_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'form_atendente.dart';

class EditAtendentePage extends StatefulWidget {
  final String id;

  const EditAtendentePage({Key key, this.id}) : super(key: key);

  @override
  _EditAtendentePageState createState() => _EditAtendentePageState();
}

class _EditAtendentePageState extends ModularState<EditAtendentePage, AtendenteController> {

  @override
  void initState() { 
    super.initState();
    
    controller.contextGlobal = context;

    controller.getAtendente(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Atendente',
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormAtendentePage(
          labelButton: 'Editar',
          buttonPressed: controller.editPressed
        ),
      ),
    );
  }
}