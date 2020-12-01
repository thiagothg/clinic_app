import 'package:flutter/material.dart';

class GlobalScaffold {
  
  static final GlobalScaffold instance = GlobalScaffold();

  final scaffKey = GlobalKey<ScaffoldState>();

  SnackBar snackBar;

  void showSnackbar(SnackBar snackBar) {
    scaffKey.currentState.showSnackBar(snackBar);
  }

  void createSnackBar({
    @required String text, 
    @required Color background}) {

    snackBar = SnackBar(
      backgroundColor: background,
      content: Text(text,
        textAlign: TextAlign.center,
      ),
    );

    showSnackbar(snackBar);
  } 
}