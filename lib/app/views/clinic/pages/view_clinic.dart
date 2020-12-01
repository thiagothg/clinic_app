import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/clinic_controller.dart';
import 'form_clinic.dart';

class ViewClinicPage extends StatefulWidget {
  final String id;

  const ViewClinicPage({Key key, this.id}) : super(key: key);
  @override
  _ViewClinicPageState createState() => _ViewClinicPageState();
}

class _ViewClinicPageState extends 
  ModularState<ViewClinicPage, ClinicController> {


  @override
  void initState() {
    super.initState();
    controller.contextGlobal = context;
    
    controller.getClinic(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose view');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Clínica',
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
                  view: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}