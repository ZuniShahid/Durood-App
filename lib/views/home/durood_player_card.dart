import 'package:flutter/material.dart';

class DuroodPlayerCard extends StatelessWidget {
  final Widget child;

  const DuroodPlayerCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.0,
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 4),
              blurRadius: 1.0,
              spreadRadius: -4.0,
            ),
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -2),
              blurRadius: 2.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
