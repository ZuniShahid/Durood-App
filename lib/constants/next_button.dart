import 'package:flutter/material.dart';

import 'app_colors.dart';

class CommonElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  final Color backgroundColor;
  final Color textColor;

  const CommonElevatedButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.textColor = Colors.white,
      this.backgroundColor = AppColors.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(114),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
