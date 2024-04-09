import 'package:flutter/material.dart';
import 'package:alercom/src/utils/utils.dart';

class InputDecorationUI{
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
}){
    Color backgroundColor = Globals.backgroundColor;
    Color backgroundColorLite = Globals.backgroundColorLite;
    Color fontColor = Globals.fontColor;
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: backgroundColor
          )
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: backgroundColor,
              width: 2
          )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
          color: Colors.grey
      ),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: backgroundColor,)
          : null
    );
  }


}