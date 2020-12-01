import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/clinic_controller.dart';
import 'form_clinic.dart';

class EditClinicPage extends StatefulWidget {
  final String id;

  const EditClinicPage({Key key, this.id}) : super(key: key);
  @override
  _EditClinicPageState createState() => _EditClinicPageState();
}

class _EditClinicPageState extends 
  ModularState<EditClinicPage, ClinicController> {


  @override
  void initState() {
    super.initState();
    controller.contextGlobal = context;
    
    controller.getClinic(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose edit');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Clínica',
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
                labelButton: 'Editar',
                buttonPressed: controller.editPressed
              )
            ],
          ),
        ),
      ),
    );
  }
}