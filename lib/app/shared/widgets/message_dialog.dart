import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showMessageDialog(
  BuildContext context, {
  @required String title,
  @required String content,
  @required List<Widget> actions,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      });
}
