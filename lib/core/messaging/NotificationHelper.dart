/*
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/mixins/logging_mixin.dart';
import '../utils/AppHelper.dart';

class NotificationHelper with LoggingMixin {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: DarwinInitializationSettings());

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<String?> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await Future.delayed(const Duration(seconds: 2));
    // Request permissions on iOS
    await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false);

    String? token;
    try {
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        print("APNS TOKEN: $apnsToken");
      }

      token = await messaging.getToken();
      print("DEVICE TOKEN --> $token");
    } catch (e) {
      print("ISSUE IN GETTING DEVICE TOKEN $e");
    }

    return token;
  }

  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails? androidPlatformChannelSpecifics;

    if (message.notification != null && message.notification!.android != null) {
      final imageUrl =
          message.data['image'] ?? message.notification?.android?.imageUrl;
      String? imagePath;
      if (imageUrl != null) {
        imagePath =
            await AppHelper.downloadAndSaveImage(imageUrl, 'big_picture.jpg');
      }

      final bigPictureStyleInformation = imagePath != null
          ? BigPictureStyleInformation(FilePathAndroidBitmap(imagePath!),
              contentTitle: message.notification!.title,
              summaryText: message.notification!.body)
          : null;

      androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'default_channel',
        'Default',
        styleInformation: bigPictureStyleInformation,
        channelDescription: 'Default channel for notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
    }

    DarwinNotificationDetails? iosDetails;
    if (Platform.isIOS && message.notification!.apple != null) {
      final imageUrl = message.notification!.apple!.imageUrl ?? "";
      final String? largeIconPath =
          await AppHelper.downloadAndSaveImage(imageUrl, 'big_picture.jpg');
      if (largeIconPath != null) {
        final DarwinNotificationAttachment attachment =
            DarwinNotificationAttachment(largeIconPath ?? "");

        iosDetails = DarwinNotificationDetails(
          attachments: [attachment],
        );
      }
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void firebaseMessagingListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //if (message.notification != null) {
      showNotification(message);
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle navigation or deep link when user taps notification
      print("Notification opened: ${message.data}");
    });
  }
}
*/
