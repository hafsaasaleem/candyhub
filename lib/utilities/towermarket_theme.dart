import 'package:flutter/material.dart';
import 'package:towermarket/utilities/towermarket_colors.dart';
import 'package:towermarket/utilities/towermarket_text_style.dart';

abstract class TowermarketTheme {
  static ThemeData get standard {
    return ThemeData(
      scaffoldBackgroundColor: TowermarketColors.white,
      appBarTheme: _appBarTheme(),
    );
  }

  static AppBarTheme _appBarTheme() => AppBarTheme(
        backgroundColor: TowermarketColors.brick,
        titleTextStyle: TowermarketTextStyle.heading2.copyWith(
          color: TowermarketColors.white,
        ),
      );
}
