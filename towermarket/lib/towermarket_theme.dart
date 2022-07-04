import 'package:flutter/material.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

import 'colors/towermarket_colors.dart';

class TowermarketTheme {
  static ThemeData get standard {
    return ThemeData(
      scaffoldBackgroundColor: TowermarketColors.white,
      appBarTheme: AppBarTheme(
          titleTextStyle: TowermarketTextStyle.heading4,
          iconTheme: const IconThemeData(color: TowermarketColors.black)),
      inputDecorationTheme: _inputDecvvvorationTheme(),
      indicatorColor: TowermarketColors.white,
      colorScheme: const ColorScheme.light(primary: TowermarketColors.white),
      primaryColor: TowermarketColors.brick,
      primaryColorLight: TowermarketColors.brick,
      tabBarTheme: const TabBarTheme(indicatorSize: TabBarIndicatorSize.tab),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(
        color: TowermarketColors.black,
        size: 24.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TowermarketColors.brick,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: TowermarketColors.brick)),
    );
  }

  static InputDecorationTheme _inputDecvvvorationTheme() =>
      const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
      );
}
