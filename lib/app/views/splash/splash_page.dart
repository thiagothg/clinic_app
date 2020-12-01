import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/core/consts/assets_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();

    controller.callLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AssetsConst.logo,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            SizedBox(
              height: 20,
            ),
            Text(ConstsApp.appName,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('Versão ${ConstsApp.versionApp}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black54
              ),
            ),
          ],
        ),
      ),
    );
  }
}
