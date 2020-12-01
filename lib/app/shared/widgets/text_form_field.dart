import 'package:flutter/material.dart';

Widget textFormField({
  @required String labelText,
  @required TextEditingController controller,
  bool enabled = true,
  String Function(String) validator,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
  bool obscureText = false,
  bool readOnly = false,
  textColor = Colors.black,
  Function(String) onChanged,
  Function onEditingComplete,
  Function onTap,
  Widget prefix,
  Widget suffix,
  String initialValue,
}) {
  return TextFormField(
    onTap: onTap,
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLines: maxLines,
    enabled: enabled,
    readOnly: readOnly,
    onChanged: onChanged,
    style: TextStyle(
      color: textColor,
      fontSize: 18
    ),
    onEditingComplete: onEditingComplete,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      prefixIcon: prefix,
      suffixIcon: suffix,
      errorStyle: TextStyle(
        fontSize: 14
      )
    ),
  );
}