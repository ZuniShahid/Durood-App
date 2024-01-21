import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

import 'constants/themes.dart';
import 'controllers/lazy_controller.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          theme: Styles.themeData(false, context),
          home: const SplashScreen(),
        ),
      );
    });
  }
}
