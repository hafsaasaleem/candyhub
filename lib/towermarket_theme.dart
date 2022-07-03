import 'package:flutter/material.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

import 'colors/towermarket_colors.dart';

class TowermarketTheme {
  static ThemeData get standard {
    return ThemeData(
      scaffoldBackgroundColor: TowermarketColors.white,
      appBarTheme: AppBarTheme(titleTextStyle: TowermarketTextStyle.heading4),
      inputDecorationTheme: _inputDecvvvorationTheme(),
      indicatorColor: TowermarketColors.white,
      colorScheme: ColorScheme.light(primary: TowermarketColors.white),
      primaryColor: TowermarketColors.brick,
      primaryColorLight: TowermarketColors.brick,
      tabBarTheme: TabBarTheme(indicatorSize: TabBarIndicatorSize.tab),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(
        color: TowermarketColors.black,
        size: 24.0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
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
