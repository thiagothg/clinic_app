import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingBody() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 15),
        Text('Carregando...')
      ],
    ),
  );
}
