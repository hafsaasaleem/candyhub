import 'package:flutter/cupertino.dart';
import 'package:towermarket/colors/towermarket_colors.dart';

abstract class TowermarketTextStyle {
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: "GoogleSans",
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: TowermarketColors.black,
  );

  static TextStyle get heading4 {
    return _baseStyle.copyWith(
      fontFamily: "GoogleSans",
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: TowermarketColors.black,
    );
  }

  static TextStyle get title2 {
    return _baseStyle.copyWith();
  }

  static TextStyle get title3 {
    return _baseStyle.copyWith(
      fontSize: 14,
    );
  }

  static TextStyle get title4 {
    return _baseStyle.copyWith(
      fontSize: 13.5,
    );
  }
}