/*
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppIcons.dart';

import '../utils/AppColors.dart';

class NotificationUtils {
  NotificationUtils._();

  factory NotificationUtils() => _instance;
  static final NotificationUtils _instance = NotificationUtils._();
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  Future<void> configuration() async {
    await awesomeNotifications.initialize(
        AppIcons.app_logo,
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic Channel',
              channelDescription: 'Basic Channel Description',
              importance: NotificationImportance.High,
              defaultColor: AppColors.sr_card_color,
              channelShowBadge: true,
              channelGroupKey: 'basic_channel_group')
        ],
        debug: true);
  }

  void checkPermissionNotification(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t Allow',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
                child: const Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Future<void> startListeningNotificationEvents() async {
    print("check data with start listing");
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate
      */
/*if (receivePort == null) {
        print(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
        IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          print('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }*//*

      print("check data with receivedAction 3$receivedAction");

      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    */
/*await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");*//*

  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
  //  print("check data with receivedAction${MyApp.navigatorKey.currentState}");
  //  print("check data with receivedAction${MyApp.navigatorKey.currentContext}");
    */
/*if (receivedAction.buttonKeyInput == "buyNow") {
    } else if (receivedAction.buttonKeyInput == "addToCart") {
    } else {
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => ProductDetailPage(
              receivedAction.bigPicture ?? "",
              "Hoodies for unisex",
              receivedAction.body ?? "")));
    }*//*

  }




  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("onNotificationCreatedMethod");

    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    print("onNotificationDisplayedMethod");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    print("onDismissActionReceivedMethod");
  }

}
*/
