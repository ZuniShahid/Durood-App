import 'package:durood_app/utilities/widgets/custom_toast.dart';
import 'package:durood_app/views/home/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/next_button.dart';
import '../../../constants/page_navigation.dart';
import '../../../generated/assets.dart';
import 'post_login_onboarding.dart';

class EnableNotificationScreen extends StatelessWidget {
  const EnableNotificationScreen({super.key});

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
                      image: AssetImage(Assets.imagesEnableNOTIBG),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0, top: 10.0.h),
                    child: TextButton(
                      onPressed: () {
                        Go.offUntil(() => const BottomNavBar());
                      },
                      child: const Text(
                        'SKIP',
                        style: TextStyle(color: Colors.white),
                      ),
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
                  Assets.imagesBell,
                  width: 100,
                  height: 64,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Get Daily Affirmations',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enable notifications to start your day with a positive affirmation, delivered to you every morning.',
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
                  onPressed: () async {
                    PermissionStatus status =
                        await Permission.notification.status;

                    if (status.isDenied) {
                      await Permission.notification.request();
                    } else if (status.isGranted) {
                      CustomToast.successToast(
                          message: 'Already Permission Accessed');
                    } else {}
                  },
                  label: 'Enable Notifications',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
                child: CommonElevatedButton(
                  onPressed: () {
                    Go.to(() => const PostOnBoardingScreen());
                  },
                  label: 'Continue',
                  textColor: AppColors.accentColor,
                  backgroundColor: AppColors.GreyLightButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
