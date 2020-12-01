import 'package:clinic_app/app/core/consts/routers_const.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:clinic_app/app/shared/widgets/error_body.dart';
import 'package:clinic_app/app/shared/widgets/loading_body.dart';
import 'package:clinic_app/app/views/clinic/widgets/clinc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/clinic_controller.dart';

class ClinicPage extends StatefulWidget {
  final String title;
  const ClinicPage({Key key, this.title = "Clinic"}) : super(key: key);

  @override
  _ClinicPageState createState() => _ClinicPageState();
}

class _ClinicPageState extends ModularState<ClinicPage, ClinicController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.contextGlobal = context;
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose list');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clínicas',
          style: TextStyle(
            fontSize: 22
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.plus),
            color: Colors.white,
            onPressed: () {
              Modular.link.pushNamed(RoutersConst.addClinicScreen)
                .then((value) => controller.contextGlobal = context);
            },
          ),
        ],
      ),
      body: Hero(
        tag: 'imageHero-Clínicas-0',
        child: streamBuilder(),
      ),
    );
  }

  streamBuilder() {
    return StreamBuilder<List<ClinicModel>>(
      stream: controller.getListClinic(),
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

  Widget body(List<ClinicModel> list) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) {
            return ClinicItem(
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
