import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/core/consts/assets_const.dart';
import 'package:clinic_app/app/core/consts/routers_const.dart';
import 'package:clinic_app/app/views/home/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Olá, ${controller?.userStore?.userModel?.name}',
          textAlign: TextAlign.left,
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
            CardWidget(
              iconImg: AssetsConst.clinicIcon,
              titleCard: 'Clínicas',
              iconData: FontAwesomeIcons.hospitalAlt,
              onTap: () {
                Modular.to.pushNamed(RoutersConst.clinicScreen);
              },
            ),
            SizedBox(height: 15),
            CardWidget(
              iconImg: AssetsConst.atendenteIcon,
              titleCard: 'Atendentes',
              iconData: FontAwesomeIcons.headset,
              onTap: () {
                Modular.to.pushNamed(RoutersConst.atendenteScreen);
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
