import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/atendente_controller.dart';
import 'form_atendente.dart';

class ViewAtendentePage extends StatefulWidget {
  final String id;

  const ViewAtendentePage({Key key, this.id}) : super(key: key);

  @override
  _ViewAtendentePageState createState() => _ViewAtendentePageState();
}

class _ViewAtendentePageState extends 
  ModularState<ViewAtendentePage, AtendenteController> {

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
        title: Text('Visualizar Atendente',
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormAtendentePage(
          view: true,
        ),
      ),
    );
  }
}