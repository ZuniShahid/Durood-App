import 'package:flutter/material.dart';

import '../views/auth/signup_page.dart';
import 'app_colors.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;

  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (login) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "Need an account? " : "Already have an account? ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            login ? "Sign Up" : "Log In",
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: AppColors.accentColor,
            ),
          )
        ],
      ),
    );
  }
}
