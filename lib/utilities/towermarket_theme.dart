import 'package:flutter/material.dart';
import 'package:towermarket/utilities/towermarket_colors.dart';
import 'package:towermarket/utilities/towermarket_text_style.dart';

abstract class TowermarketTheme {
  static ThemeData get standard {
    return ThemeData(
      textTheme: TextTheme(
        titleMedium: TowermarketTextStyle.title1,
      ),
      scaffoldBackgroundColor: TowermarketColors.white,
      appBarTheme: _appBarTheme(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static AppBarTheme _appBarTheme() => AppBarTheme(
        backgroundColor: TowermarketColors.purple,
        titleTextStyle: TowermarketTextStyle.heading3.copyWith(
          color: TowermarketColors.white,
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          backgroundColor: TowermarketColors.purple,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 4, right: 4),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 0.6,
            color: TowermarketColors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            width: 0.6,
            color: TowermarketColors.black,
          ),
        ),
      );
}
