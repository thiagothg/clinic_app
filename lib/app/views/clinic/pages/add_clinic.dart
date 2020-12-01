import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/clinic_controller.dart';
import 'form_clinic.dart';

class AddClinicPage extends StatefulWidget {
  @override
  _AddClinicPageState createState() => _AddClinicPageState();
}

class _AddClinicPageState extends 
  ModularState<AddClinicPage, ClinicController> {


  @override
  void initState() {
    super.initState();
    print('init add');
    controller.contextGlobal= context;
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose add');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Clínica',
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormClinic(
                labelButton: 'Salvar',
                buttonPressed: controller.savePressed
              ),
            ],
          ),
        ),
      ),
    );
  }
}