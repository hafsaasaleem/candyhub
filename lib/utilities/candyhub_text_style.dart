import 'package:flutter/cupertino.dart';
import 'package:candyhub/utilities/candyhub_colors.dart';

abstract class CandyHubTextStyle {
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: "SourceSansPro",
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: CandyHubColors.black,
  );

  static TextStyle get large {
    return _baseStyle.copyWith(
      fontFamily: "GoogleSans",
      fontWeight: FontWeight.w600,
      fontSize: 32,
      color: CandyHubColors.purple,
    );
  }

  static TextStyle get heading1 {
    return _baseStyle.copyWith(
      fontFamily: "GoogleSans",
      fontWeight: FontWeight.w600,
      fontSize: 24,
      color: CandyHubColors.black,
    );
  }

  static TextStyle get heading2 {
    return _baseStyle.copyWith(
      fontFamily: "GoogleSans",
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: CandyHubColors.white,
    );
  }

  static TextStyle get heading3 {
    return _baseStyle.copyWith(
      fontFamily: "GoogleSans",
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: CandyHubColors.black,
    );
  }

  static TextStyle get heading4 {
    return _baseStyle.copyWith(
      fontFamily: "GoogleSans",
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: CandyHubColors.white,
    );
  }

  static TextStyle get title1 {
    return _baseStyle.copyWith(
      fontSize: 18,
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

  static TextStyle get title5 {
    return _baseStyle.copyWith(
      fontSize: 12.5,
    );
  }
}
