import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/app_colors.dart';
import '../constants/page_navigation.dart';
import '../controllers/auth_controller.dart';
import '../main.dart';
import '../preferences/auth_prefrence.dart';
import '../utilities/push_notification.dart';
import 'home/bottom_nav_bar.dart';
import 'onboarding/onboarding_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");

  // Check if the message contains a notification
  if (message.data.containsKey('link')) {
    String? link = message.data['link'];
    if (link != null && link.isNotEmpty) {
      launchUrls(link);
    }
  }
}

setNotificationData() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final PushNotificationService obj = PushNotificationService();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  final AuthController _authController = Get.find<AuthController>();
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setNotificationData();
    _navigate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_appLifecycleState == AppLifecycleState.resumed && state == AppLifecycleState.paused) {
      decrementGlobalCounter(_authController.accessToken.value);
    }
    _appLifecycleState = state;
  }

  Future<void> incrementGlobalCounter(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://eramsaeed.com/Durood-App/api/increment-global-counter'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('increment count');
      } else {
        print('Error incrementing global counter. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error incrementing global counter: $e');
    }
  }

  Future<void> decrementGlobalCounter(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://eramsaeed.com/Durood-App/api/decrement-global-counter'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('decrement count');
      } else {
        print('Error decrementing global counter. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error decrementing global counter: $e');
    }
  }

  _navigate() async {
    bool isLoggedIn = await AuthPrefrence.instance.getUserLoggedIn();

    if (isLoggedIn) {
      String accessToken = await AuthPrefrence.instance.getUserDataToken();
      incrementGlobalCounter(accessToken);
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
