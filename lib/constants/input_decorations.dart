import 'package:flutter/material.dart';

import 'app_colors.dart';

class InputDecorations {
  static InputDecoration inputDecorationNoBorder({hintText = ""}) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.black.withOpacity(0.4),
        ),
      );

  static InputDecoration inputDecorationAllBorder({hintText = ""}) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.textGrey,
        ),
        border: InputBorder.none,
      );
}
