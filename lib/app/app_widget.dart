import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/widgets/global_scaffold.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Flutter Slidy',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(156, 204, 101, 1),
        primarySwatch: Colors.blue,
        fontFamily: 'Futura',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            )
          )
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
       builder: (context, child) {
        return Scaffold(
          key: GlobalScaffold.instance.scaffKey,
          body: child,
        );
      },
    );
  }
}
