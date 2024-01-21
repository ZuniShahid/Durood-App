import 'package:get/get.dart';

class PageTransition {
  static fadeInNavigation({required page}) {
    Get.to(page,
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300));
  }

  static leftToRightNavigation({required page}) {
    Get.to(page,
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 300));
  }

  static cupertinoNavigation({required page}) {
    Get.to(page,
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 300));
  }

  static leftToRightWithFadeNavigation({required page}) {
    Get.to(page,
        transition: Transition.leftToRightWithFade,
        duration: const Duration(milliseconds: 300));
  }
}
