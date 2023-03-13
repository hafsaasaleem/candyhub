import 'package:flutter/material.dart';
import 'package:candyhub/utilities/candyhub_colors.dart';
import 'candyhub_text_style.dart';

abstract class CandyHubTheme {
  static ThemeData get standard {
    return ThemeData(
      textTheme: TextTheme(
        titleMedium: CandyHubTextStyle.title1,
      ),
      scaffoldBackgroundColor: CandyHubColors.white,
      appBarTheme: _appBarTheme(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static AppBarTheme _appBarTheme() => AppBarTheme(
        backgroundColor: CandyHubColors.purple,
        titleTextStyle: CandyHubTextStyle.heading3.copyWith(
          color: CandyHubColors.white,
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          backgroundColor: CandyHubColors.purple,
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
            color: CandyHubColors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            width: 0.6,
            color: CandyHubColors.black,
          ),
        ),
      );
}
