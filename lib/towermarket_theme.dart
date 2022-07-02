import 'package:flutter/material.dart';

import 'colors/towermarket_colors.dart';

class TowermarketTheme {
  static ThemeData get standard {
    return ThemeData(
      inputDecorationTheme: _inputDecvvvorationTheme(),
      indicatorColor: TowermarketColors.white,
      colorScheme: ColorScheme.light(
        primary: TowermarketColors.brick,
      ),
      primaryColor: TowermarketColors.brick,
      primaryColorLight: TowermarketColors.brick,
      tabBarTheme: TabBarTheme(indicatorSize: TabBarIndicatorSize.tab),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(
        color: TowermarketColors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: TowermarketColors.brick,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(fixedSize: const Size(120, 46)),
      ),
    );
  }

  static InputDecorationTheme _inputDecvvvorationTheme() =>
      const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
      );
}
