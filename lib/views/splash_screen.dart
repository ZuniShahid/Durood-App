import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/page_navigation.dart';
import '../controllers/auth_controller.dart';
import '../preferences/auth_prefrence.dart';
import '../utilities/push_notification.dart';
import 'home/bottom_nav_bar.dart';
import 'onboarding/onboarding_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
  RemoteMessage navigate = message;
}

setNotificationData() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final PushNotificationService obj = PushNotificationService();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((obj.handleMessage));
  FirebaseMessaging.onMessage.listen((obj.selectNotification));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(obj.channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true, provisional: true);
}

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
    setNotificationData();
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
