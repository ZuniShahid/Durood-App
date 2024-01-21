import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/app_colors.dart';
import '../../generated/assets.dart';
import '../../constants/next_button.dart';
import '../auth/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildPageView(),
                _currentPage == 0
                    ? const SizedBox.shrink()
                    : _buildBackButton(),
                _buildLogoAndPageIndicator(),
                _buildNextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      children: const [
        OnboardingPage(
          backgroundImage: Assets.imagesIntro1,
          pageText: 'Immerse yourself in the divine serenity of Durood',
        ),
        OnboardingPage(
          backgroundImage: Assets.imagesIntro2,
          pageText:
              'Join hands with believers worldwide as we harmonize our prayers',
        ),
        OnboardingPage(
          backgroundImage: Assets.imagesIntro3,
          pageText:
              'Let the world resonate with the sacred verses as hearts unite in a symphony of faith.',
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 10.0.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoAndPageIndicator() {
    return Positioned(
      top: 50.h,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesLogo,
                  height: 100,
                  width: 80,
                ),
                const SizedBox(height: 15),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 6,
                    dotWidth: 40,
                    radius: 0,
                    dotColor: Colors.grey.withOpacity(0.5),
                    activeDotColor: AppColors.accentColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
        child: CommonElevatedButton(
          onPressed: () {
            if (_currentPage < 2) {
              _pageController.animateToPage(
                _currentPage + 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else {
              Get.offAll(() => const LoginScreen());
              // Handle last page navigation or completion
            }
          },
          label: _currentPage == 2 ? 'Discover Now' : 'Next',
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String backgroundImage;
  final String pageText;

  const OnboardingPage({
    super.key,
    required this.backgroundImage,
    required this.pageText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 70.h,
          width: 100.w,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              pageText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
