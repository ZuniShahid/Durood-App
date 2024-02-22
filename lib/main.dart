import 'package:firebase_core/firebase_core.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'controllers/lazy_controller.dart';
import 'firebase_options.dart';
import 'utilities/theme.dart';
import 'views/splash_screen.dart';

Future<void> _firebaseMessBackgroundHand(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification == null) return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessBackgroundHand);
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    incrementGlobalCounter();
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }

  Future<void> backgroundFetchHeadlessTask(HeadlessTask task) async {
    // Check if it's been a significant time since last foreground interaction
    final lastForegroundTimestamp = await SharedPreferences.getInstance();
    final lastForegroundTime = lastForegroundTimestamp.getInt('lastForegroundTime');
    final now = DateTime.now().millisecondsSinceEpoch;
    final timeSinceForeground = now - lastForegroundTime!;

    if (timeSinceForeground > 9) {
      // 9 seconds
      decrementGlobalCounter(); // Assume user has exited
      SharedPreferences.getInstance().then((prefs) => prefs.setInt('lastForegroundTime', now));
    }

    BackgroundFetch.finish(task.taskId);
  }

  Future<void> incrementGlobalCounter() async {
    try {
      await http.post(Uri.parse('https://eramsaeed.com/Durood-App/api/increment-global-counter'));
      print('increment count');
    } catch (e) {
      print('Error incrementing global counter: $e');
    }
  }

  Future<void> decrementGlobalCounter() async {
    try {
      await http.post(Uri.parse('https://eramsaeed.com/Durood-App/api/decrement-global-counter'));
      print('decrement count');
    } catch (e) {
      print('Error decrementing global counter: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = ThemeData.light().textTheme;
    MaterialTheme myMaterialTheme = MaterialTheme(myTextTheme);
    ThemeData myTheme = myMaterialTheme.light();
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: GetMaterialApp(
            initialBinding: LazyController(),
            debugShowCheckedModeBanner: false,
            title: 'Durood App',
            theme: myTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
