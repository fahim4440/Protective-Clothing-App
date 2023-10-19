import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors of the theme
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkprimary,

    splashColor: ColorManager.backgroundColorOpacity70,
    disabledColor: ColorManager.grey1,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

    //card view theme
    cardTheme: CardTheme(
      color: ColorManager.backgroundColorOpacity70,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    //appbar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      titleTextStyle: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s20),
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      splashColor: ColorManager.primaryOpacity70,
      buttonColor: ColorManager.primary,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    //Text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
      titleMedium: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
      titleSmall: getSemiBoldStyle(color: ColorManager.darkprimary, fontSize: FontSize.s18),
      bodySmall: getRegularStyle(color: ColorManager.grey1),
      bodyLarge: getRegularStyle(color: ColorManager.grey),
    ),

    //input decoration (text-form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
      ),
    ),
  );
}
