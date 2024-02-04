import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/page_navigation.dart';
import '../controllers/auth_controller.dart';
import '../preferences/auth_prefrence.dart';
import 'home/bottom_nav_bar.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    bool isLoggedIn = await AuthPrefrence.instance.getUserLoggedIn();

    if (isLoggedIn) {
      Future.delayed(const Duration(milliseconds: 4000), () {
        Go.offUntil(() => const BottomNavBar());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 4000), () {
        Go.offUntil(() => const OnboardingScreen());
        // Go.offUntil(() => const LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo here
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
