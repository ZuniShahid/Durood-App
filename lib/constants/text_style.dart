import 'package:flutter/material.dart';

class CustomTextStyles {
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

  static TextStyle subtitleStyle({
    double fontSize = 16,
    Color color = Colors.grey,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }

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

  static TextStyle errorTextStyle({
    double fontSize = 14,
    Color color = Colors.red,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }

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
