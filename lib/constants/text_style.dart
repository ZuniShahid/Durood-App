import 'package:flutter/material.dart';

class CustomTextStyles {
  // 1. Title text style
  static TextStyle titleStyle({
    double fontSize = 20,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // 2. Subtitle text style
  static TextStyle subtitleStyle({
    double fontSize = 16,
    Color color = Colors.grey,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }

  // 3. Body text style
  static TextStyle bodyTextStyle({
    double fontSize = 14,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // 4. Button text style
  static TextStyle buttonTextStyle({
    double fontSize = 14,
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // 5. Error text style
  static TextStyle errorTextStyle({
    double fontSize = 14,
    Color color = Colors.red,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }

  // 6. Link text style
  static TextStyle linkTextStyle({
    double fontSize = 16,
    Color color = Colors.blue,
    TextDecoration decoration = TextDecoration.underline,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      decoration: decoration,
    );
  }

  // 7. Highlighted text style
  static TextStyle highlightedTextStyle({
    double fontSize = 16,
    Color color = Colors.orange,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // 8. Caption text style
  static TextStyle captionTextStyle({
    double fontSize = 10,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // 9. Header text style
  static TextStyle headerTextStyle({
    double fontSize = 28,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // 10. Placeholder text style
  static TextStyle placeholderTextStyle({
    double fontSize = 16,
    Color color = Colors.grey,
    FontStyle fontStyle = FontStyle.italic,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontStyle: fontStyle,
    );
  }
}
