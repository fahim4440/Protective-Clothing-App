import 'font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, fontWeight: fontWeight, color: color);
}

TextStyle getRegularStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

TextStyle getMediumRegularStyle({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

TextStyle getLargeRegularStyle({double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

TextStyle getLightStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}

TextStyle getMediumStyle({double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}

TextStyle getLargeBoldStyle({double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}

TextStyle getExtraLargeBoldStyle({double fontSize = FontSize.s24, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}