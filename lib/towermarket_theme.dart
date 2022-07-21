import 'package:flutter/material.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

import 'colors/towermarket_colors.dart';

class TowermarketTheme {
  static ThemeData get standard {
    return ThemeData(
      scaffoldBackgroundColor: TowermarketColors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: TowermarketColors.white,
          titleTextStyle: TowermarketTextStyle.heading4,
          iconTheme: const IconThemeData(color: TowermarketColors.black)),
      inputDecorationTheme: _inputDecorationTheme,
      indicatorColor: TowermarketColors.white,
      // colorScheme: const ColorScheme.light(primary: TowermarketColors.white),
      primaryColor: TowermarketColors.peru,
      primaryColorLight: TowermarketColors.peru,
      tabBarTheme: const TabBarTheme(indicatorSize: TabBarIndicatorSize.tab),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(
        color: TowermarketColors.black,
        size: 24.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TowermarketColors.peru,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: TowermarketColors.brick)),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme =>
      const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
      );
}
