import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PushNotificationService {
  late RemoteMessage? navigate;

  _navigation() {
    if (navigate != null && navigate!.data.containsKey('link')) {
      String? link = navigate!.data['link'];
      if (link != null && link.isNotEmpty) {
        _launchUrl(link);
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    print("_url");
    print(_url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void handleMessage(RemoteMessage message) {
    print("in app open handleMessage");
    navigate = message;

    _navigation();
  }

  void onSelectNotification(String? payload) async {
    print("onSelectNotification");
    _navigation();
  }

  void onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
    print("onDidReceiveLocalNotification");
    _navigation();
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    print("onDidReceiveNotificationResponse");
    _navigation();
  }

  void selectNotification(RemoteMessage message) async {
    print("selectNotification");
    navigate = message;
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'high_importance_channel', 'High Importance Notifications',
        importance: Importance.high, priority: Priority.high, icon: "app_icon");
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    print("message.data");
    print(message.data);
    print(message.data);
    print("Payload: ${message.data}");
    print("Data: ${message.notification!.body}");
    print("Notification: ${message.notification!.body}");
    print("Notification Title: ${message.notification!.title}");
    print("Payload:");
    message.data.forEach((key, value) {
      print('$key: $value');
    });

    // var res = jsonDecode(message.data['notification']);
    // print('RES: $res');
    if (GetPlatform.isAndroid) {
      await FlutterLocalNotificationsPlugin().show(
          123, message.notification!.title, message.notification!.body, platformChannelSpecifics,
          payload: 'data');
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    FlutterLocalNotificationsPlugin()
        .initialize(initializationSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<void> initNotification() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS);
    );
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title // description
      importance: Importance.high,
      playSound: true);
}
