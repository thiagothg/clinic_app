import 'package:flutter/material.dart';

lockScreen(BuildContext context, {@required String text}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          // ignore: missing_return
          onWillPop: () {},
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text(text),
              ],
            ),
          ),
        );
      });
}