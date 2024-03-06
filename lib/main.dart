import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

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
