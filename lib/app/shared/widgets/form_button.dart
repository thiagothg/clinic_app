import 'package:flutter/material.dart';

Widget formButton(BuildContext context,
    {@required String text, @required Function onTap}) {
  return SafeArea(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
  );
}

Widget submitButton(BuildContext context,
    {@required String text, 
    @required Function onTap, 
    @required bool loading,
    @required Function loginPressed}) {
  return SizedBox(
    height: 60,
    width: 400,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      // alignment: Alignment.center,
      // width: 400,
      // height: 60,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).primaryColor,
      //   borderRadius: BorderRadius.circular(5),
      // ),
      color: Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).primaryColor.withAlpha(100),
      textColor: Colors.white,
      onPressed: loginPressed,
      child: loading ?
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ) : 
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
    ),
  );
}
