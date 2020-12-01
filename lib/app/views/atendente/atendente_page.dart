import 'package:clinic_app/app/core/consts/routers_const.dart';
import 'package:clinic_app/app/models/atendente_model.dart';
import 'package:clinic_app/app/shared/widgets/error_body.dart';
import 'package:clinic_app/app/shared/widgets/loading_body.dart';
import 'package:clinic_app/app/views/atendente/widgets/atendente_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/atendente_controller.dart';

class AtendentePage extends StatefulWidget {
  final String title;
  const AtendentePage({Key key, this.title = "Atendente"}) : super(key: key);

  @override
  _AtendentePageState createState() => _AtendentePageState();
}

class _AtendentePageState
    extends ModularState<AtendentePage, AtendenteController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.contextGlobal = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.globalScaffoldKey,
      appBar: AppBar(
        title: Text('Lista de Atendente',
          style: TextStyle(
            fontSize: 22
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.plus),
            color: Colors.white,
            onPressed: () {
              Modular.link.pushNamed(RoutersConst.addAtendenteScreen);
            },
          ),
        ],
      ),
      body: Hero(
        tag: 'imageHero-Atendentes-0',
        child: streamBuilder(),
      ),
    );
  }

  streamBuilder() {
    return StreamBuilder<List<AtendenteModel>>(
      stream: controller.getListAtendentes(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return errorBody();
            break;
          case ConnectionState.waiting:
            return loadingBody();
            break;
          default:
            if(snapshot.data.length > 0)
              return body(snapshot.data);
            else
              return emptyBody();
            break;
        }
      },
    );
  }

  Widget body(List<AtendenteModel> list) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) {
            return AtendenteItem(
              model: list[i],
            );
          }
        ),
      )
    );
  }

  Widget emptyBody() {
    return Center(
      child: Text('Nenhum resultado encontrado.',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
