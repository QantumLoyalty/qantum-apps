/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/data/models/NetworkResponse.dart';
import 'package:qantum_apps/views/common_widgets/AppButton.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';

class PushnotificationSample extends StatefulWidget {
  const PushnotificationSample({super.key});

  @override
  State<PushnotificationSample> createState() => _PushnotificationSampleState();
}

class _PushnotificationSampleState extends State<PushnotificationSample> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) {
        try {
          launchGame();
          print("NOTIFICATION:::::::: ${payload.payload}");
        } catch (e) {
          print("Error in launching game :$e");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: AppButton(
                onClick: showPushNotification,
                text: "SEND NOTIFICATION",
              ),
            ),
            AppLoader(),
          ],
        ),
      ),
    );
  }

  void showPushNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id', // Channel ID
      'channel_name', // Channel Name
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Star Reward', // Notification Title
      'Game Notification - Launch game', // Notification Body
      platformChannelSpecifics,
      payload: 'Notification Payload', // Optional
    );
  }

  launchGame() {
    StreamController<int> controller = StreamController<int>();
    int selectedIndex = 0;
    bool? animationEnd;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                child: Container(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: 32,
                            )),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: FortuneWheel(
                                  selected: controller.stream,
                                  animateFirst: false,
                                  onAnimationEnd: () {
                                    print(
                                        "Congrats!!!, you won ${selectedIndex}");

                                    setState(() {
                                      animationEnd = true;
                                    });
                                  },
                                  items: const [
                                    FortuneItem(child: Text("10")),
                                    FortuneItem(child: Text("20")),
                                    FortuneItem(child: Text("30")),
                                    FortuneItem(child: Text("40")),
                                    FortuneItem(child: Text("50")),
                                    FortuneItem(child: Text("60")),
                                    FortuneItem(child: Text("70")),
                                    FortuneItem(child: Text("80")),
                                    FortuneItem(child: Text("90")),
                                    FortuneItem(child: Text("100")),
                                  ]),
                            ),
                            AppDimens.shape_40,
                            AppButton(
                                text: "Start",
                                onClick: () {
                                  setState(() {
                                    selectedIndex = Fortune.randomInt(0, 10);
                                    controller.add(selectedIndex);
                                  });
                                })
                          ],
                        ),
                      ),
                      animationEnd != null && animationEnd!
                          ? Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Congratulations!',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AppDimens.shape_20,
                                    Icon(
                                      Icons.check_circle,
                                      size: 72,
                                      color: Colors.green,
                                    ),
                                    AppDimens.shape_20,
                                    Text(
                                      "You have won ${(selectedIndex + 1) * 10} points.",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    AppDimens.shape_30,
                                    AppButton(
                                      text: 'Close',
                                      onClick: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
*/
