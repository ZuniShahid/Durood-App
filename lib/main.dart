import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controllers/lazy_controller.dart';
import 'utilities/theme.dart';
import 'views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
