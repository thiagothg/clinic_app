import 'package:clinic_app/app/controllers/clinic_controller.dart';
import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/shared/validation/validation.dart';
import 'package:clinic_app/app/shared/widgets/form_button.dart';
import 'package:clinic_app/app/shared/widgets/global_scaffold.dart';
import 'package:clinic_app/app/shared/widgets/text_form_field.dart';
import 'package:clinic_app/app/views/clinic/pages/form_clinic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ViewClinicPage extends StatefulWidget {
  final String id;

  const ViewClinicPage({Key key, this.id}) : super(key: key);
  @override
  _ViewClinicPageState createState() => _ViewClinicPageState();
}

class _ViewClinicPageState extends ModularState<ViewClinicPage, ClinicController> {


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