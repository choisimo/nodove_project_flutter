import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LightStyle{
  static const Color white = Color.fromRGBO(255, 255, 255 , 1);
  static const Color grey = Color.fromRGBO(233 , 233, 233, 1);
  static const Color darkGrey = Color.fromRGBO(144, 144, 144, 1);
  static const Color black = Color.fromRGBO(56, 56, 56 , 1);
  static const Color blackAlpha = Color.fromRGBO(56, 56, 56 , 0.75);
  static const Color back = Color.fromRGBO(237,241,248, 1);
  static const Color backStr = Color.fromRGBO(116 , 135, 168, 1);
  static const Color backAlpha = Color.fromRGBO(237 , 241, 248, 0.5);

}

class DarkStyle{
  static const Color white = Color.fromRGBO(56, 56, 56 , 1);
  static const Color grey = Color.fromRGBO(155 , 155, 155, 1);
  static const Color black = Color.fromRGBO(255, 255, 255 , 1);
  static const Color blackAlpha = Color.fromRGBO(255, 255, 255 , 0.75);
  static const Color back = Color.fromRGBO(35 , 35, 35, 1);
  static const Color backStr = Color.fromRGBO(255 , 255, 255, 1);
  static const Color backAlpha = Color.fromRGBO(248 , 248, 248, 0.5);
  static const Color darkGrey = Color.fromRGBO(202, 202, 202, 1);
}

class CommonStyle{
  static const Color first = Color.fromRGBO(57, 105, 239, 1);
  static const Color firstAlpha = Color.fromRGBO(57, 105, 239, 0.5);
  static const Color second = Color.fromRGBO(109, 144, 241, 1);
  static const Color secondAlpha = Color.fromRGBO(109, 144, 241, 0.5);
  static const Color red = Color.fromRGBO(255, 100, 100 , 1);
  static const Color sky = Color.fromRGBO(215 , 242, 255, 1);
}

class Themes{
  static final ThemeData light = ThemeData.light().copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme : const AppBarTheme(
      backgroundColor: LightStyle.white
    ),
    textTheme : const TextTheme(
      bodyLarge : TextStyle(color : LightStyle.black , fontSize: 18),
      bodyMedium : TextStyle(color : LightStyle.black , fontSize: 16),
      bodySmall : TextStyle(color : LightStyle.black , fontSize: 14),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: LightStyle.black,
      onPrimary: LightStyle.white,
      secondary: LightStyle.darkGrey,
      onSecondary: LightStyle.grey,
      error: CommonStyle.red,
      onError:LightStyle.black,
      surface: LightStyle.back,
      onSurface: LightStyle.backStr,
      )
  );
    static final ThemeData dark = ThemeData.light().copyWith(
    appBarTheme : const AppBarTheme(
      backgroundColor: DarkStyle.white
    ),
    textTheme : const TextTheme(
      bodyLarge : TextStyle(color : DarkStyle.black , fontSize: 18),
      bodyMedium : TextStyle(color : DarkStyle.black , fontSize: 16),
      bodySmall : TextStyle(color : DarkStyle.black , fontSize: 14),
      
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: DarkStyle.black,
      onPrimary: DarkStyle.white,
      secondary: DarkStyle.darkGrey,
      onSecondary: DarkStyle.grey,
      error: CommonStyle.red,
      onError:DarkStyle.black,
      background: DarkStyle.back,
      onBackground: DarkStyle.backStr,
      surface: DarkStyle.white ,
      onSurface: DarkStyle.back,
      )
  );
}