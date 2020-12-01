import 'package:flutter/material.dart';

Widget errorBody() {
  return Center(
    child: Text(
      'Algo de errado aconteceu. Tente novamente mais tarde',
      style: TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
    ),
  );
}

Widget emptyBody() {
  return Center(
    child: Text(
      'Nenhum item encontrado!',
      style: TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
    ),
  );
}

