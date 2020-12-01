import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/atendente/home_atendente_controller.dart';
import '../../../core/consts/app_conts.dart';
import '../../../core/consts/assets_const.dart';
import '../../../models/clinic_model.dart';
import '../../../shared/widgets/error_body.dart';
import '../../../shared/widgets/loading_body.dart';
import 'pages/form_clinic.dart';

class HomeAtendentePage extends StatefulWidget {
  final String title;
  const HomeAtendentePage({Key key, this.title = "HomeAtendente"})
      : super(key: key);

  @override
  _HomeAtendentePageState createState() => _HomeAtendentePageState();
}

class _HomeAtendentePageState
    extends ModularState<HomeAtendentePage, HomeAtendenteController> {
  //use 'controller' variable to access controller

  @override
  void initState() { 
    super.initState();
    
    controller.contextGlobal = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Olá, ${controller?.userStore?.userModel?.name}',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app,
              size: 35,
            ),
            color: Colors.white,
            onPressed: (){
              controller.loginController.logout();
            },
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset(AssetsConst.logo,
                      height: MediaQuery.of(context).size.width * 0.25,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(ConstsApp.appName,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),

              StreamBuilder<ClinicModel>(
                stream: controller.getClinic(),
                builder: (context, snapshot) {
                   switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return errorBody();
                      break;
                    case ConnectionState.waiting:
                      return loadingBody();
                      break;
                    default:
                      if(snapshot.data != null) {
                        controller.setData(snapshot.data);
                        return body(snapshot.data);
                      }
                      else {
                        return empty();
                      }
                      break;
                  }
                  
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget body(ClinicModel model) {
   return Observer(
     builder: (context) {
       return FormClinic(
          labelButton: 'Editar',
          buttonPressed: controller.editPressed,
          model: model,
        );
     }
   );
  }

   Widget empty() {
   return Center(
      child: Text('Você não está associado a nenhuma Clínica!'),
    );
  }
}
