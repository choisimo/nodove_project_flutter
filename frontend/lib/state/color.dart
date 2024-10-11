import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalContext{
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
}

class LightStyle{
  static const Color white = Color.fromRGBO(255, 255, 255 , 1);
  static const Color grey = Color.fromRGBO(233 , 233, 233, 1);
  static const Color darkGrey = Color.fromRGBO(144, 144, 144, 1);
  static const Color black = Color.fromRGBO(56, 56, 56 , 1);
  static const Color blackAlpha = Color.fromRGBO(56, 56, 56 , 0.75);
  static const Color back = Color.fromRGBO(237, 241, 248, 1);
  static const Color backStr = Color.fromRGBO(116, 135, 168, 1);
  static const Color backAlpha = Color.fromRGBO(237 , 241, 248, 0.5);

}

class DarkStyle{
  static const Color white = Color.fromRGBO(56, 56, 56 , 1);
  static const Color grey = Color.fromRGBO(155 , 155, 155, 1);
  static const Color black = Color.fromRGBO(255, 255, 255 , 1);
  static const Color blackAlpha = Color.fromRGBO(255, 255, 255 , 0.75);
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.5);
  static const Color back = Color.fromRGBO(35 , 35, 35, 1);
  static const Color backStr = Color.fromRGBO(255 , 255, 255, 1);
  static const Color backAlpha = Color.fromRGBO(248 , 248, 248, 0.5);
  static const Color darkGrey = Color.fromRGBO(202, 202, 202, 1);
}

class CommonStyle{
  static const Color first = Color.fromRGBO(21 , 52 , 177 , 1);
  static const Color firstAlpha = Color.fromRGBO(57, 105, 239, 0.5);
  static const Color second = Color.fromRGBO(116 , 135, 168, 1);
  static const Color secondAlpha = Color.fromRGBO(116 , 135, 168, 0.5);
  static const Color firstdark = Color.fromRGBO(57,105,239, 1);
  static const Color third = Color.fromRGBO(5,135,255, 1);
  static const Color red = Color.fromRGBO(255, 100, 100 , 1);
  static const Color sky = Color.fromRGBO(215 , 242, 255, 1);
}

class RowContainer{
  static const BoxShadow shadow = BoxShadow(
    color : LightStyle.grey,
    blurRadius: 6,
    offset : Offset(0,2),
  );
  static const Offset offset = Offset(0,2);
  static const double blurRadius = 6.0;
  static const BorderRadius radius = BorderRadius.all(Radius.circular(12));
  static const Color background = LightStyle.white;
}

class RowTextStyle{
  static const TextStyle title = TextStyle(
    fontSize : 18,
  );
  static const TextStyle userId = TextStyle(
    fontSize : 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle content = TextStyle(
    fontSize : 16,
    fontWeight: FontWeight.normal
  );
  static const TextStyle subContent = TextStyle(
    fontSize : 14,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle link = TextStyle(
    color : CommonStyle.sky,
    fontSize : 14,
    decoration: TextDecoration.underline
  );
}

class Themes{
  static final ThemeData light = ThemeData.light(
    useMaterial3: true,
    ).copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    dividerColor: LightStyle.backStr,
    hoverColor: Colors.transparent,
    appBarTheme : const AppBarTheme(
      backgroundColor: LightStyle.white
    ),
    textButtonTheme: TextButtonThemeData(
      style : TextButton.styleFrom(
        foregroundColor: LightStyle.backStr
      )
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((state){
        return state.contains(WidgetState.selected)
        ? CommonStyle.first
        : null;
      }),
    ),
    cardColor: LightStyle.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: LightStyle.black,
      onPrimary: LightStyle.white,
      secondary: LightStyle.darkGrey,
      onSecondary: LightStyle.grey,
      shadow : LightStyle.grey,
      error: CommonStyle.red,
      onError:LightStyle.black,
      surface: LightStyle.back,
      onSurface: LightStyle.backStr,
      onPrimaryFixed: CommonStyle.first,
    )
  );
    static final ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    dividerColor: DarkStyle.backStr,
    hoverColor: Colors.transparent,
    appBarTheme : const AppBarTheme(
      backgroundColor: DarkStyle.white
    ),
    switchTheme: const SwitchThemeData(
      trackColor: WidgetStatePropertyAll(CommonStyle.third),
    ),
    cardColor: DarkStyle.white,
    textButtonTheme: TextButtonThemeData(
      style : TextButton.styleFrom(
        foregroundColor: DarkStyle.backStr
      )
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: DarkStyle.black,
      onPrimary: DarkStyle.white,
      secondary: DarkStyle.darkGrey,
      shadow : DarkStyle.shadow,
      onSecondary: DarkStyle.grey,
      error: CommonStyle.red,
      onError:DarkStyle.black,
      surface: DarkStyle.back,
      onSurface: DarkStyle.backStr,
      onPrimaryFixed: CommonStyle.firstdark,
      )
  );
}