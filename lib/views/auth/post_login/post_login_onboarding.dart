import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/next_button.dart';
import '../../../constants/page_navigation.dart';
import '../../../generated/assets.dart';
import '../../home/bottom_nav_bar.dart';

class PostOnBoardingScreen extends StatelessWidget {
  const PostOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
            child: Stack(
              children: [
                Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesPOSTLOGINBG),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.imagesLogo,
                  width: 100,
                  height: 64,
                  color: AppColors.accentColor,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to the Durood app by Eram',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Immerse yourself in Durood, uniting hearts globally through diverse recitations. Explore collective supplication and diverse styles in this spiritual journey.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
                child: CommonElevatedButton(
                  onPressed: () {
                    Go.offUntil(() => const BottomNavBar());
                  },
                  label: 'Continue',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
