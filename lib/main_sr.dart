import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/data/models/notification_model.dart';
import 'package:qantum_apps/services/notification_services.dart';
import '/data/local/SharedPreferenceHelper.dart';
import '../core/flavors_config/app_themes.dart';
import '../core/flavors_config/flavor_config.dart';
import '../core/navigation/AppNavigator.dart';
import '../views/splash/SplashScreen.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/InternetStatusProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UnitedFuelsProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'views/AppBootstrap.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> syncCurrentUserIdToNative(String userId) async {
  try {
    await _nativeNotificationsChannel
        .invokeMethod('setCurrentUserId', {'userId': userId});
    ('[NativeSync] userId synced to App Group: $userId').logMessage;
  } on MissingPluginException {
    // Android - normal, skip
  } catch (e) {
    ('[NativeSync] error: $e').logMessage;
  }
}

const MethodChannel _nativeNotificationsChannel =
MethodChannel('com.qantum/native_notifications');

Future<void> migratePendingNativeNotifications() async {
  try {
    final List<dynamic>? pendingList = await _nativeNotificationsChannel
        .invokeMethod('getPendingNotifications');

    if (pendingList == null || pendingList.isEmpty) {
      ('[Migration] koi pending native notification nahi mila').logMessage;
      return;
    }

    ('[Migration] ${pendingList.length} pending notifications mile, Hive me migrate kar rahe hain').logMessage;

    for (final item in pendingList) {
      try {
        final Map<String, dynamic> data = jsonDecode(item as String);

        final String id =
            data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
        final String title = data['title'] ?? '';
        final String body = data['body'] ?? '';
        final String? imageUrl = (data['imageUrl'] as String?)?.isEmpty == true
            ? null
            : data['imageUrl'] as String?;
        final String? payload = data['payload'] as String?;
        final DateTime receivedAt = data['receivedAt'] != null
            ? DateTime.tryParse(data['receivedAt']) ?? DateTime.now()
            : DateTime.now();
        final String notifUserId = data['userId'] ?? 'guest';

        final model = NotificationModel(
          id: id,
          userId: notifUserId,
          title: title,
          body: body,
          imageUrl: imageUrl,
          payload: payload,
          isRead: false,
          receivedAt: receivedAt,
        );

        await NotificationHiveService.save(model);
      } catch (e) {('[Migration] ek notification parse karne me error: $e, raw: $item').logMessage;
      }
    }

    ('[Migration] migration complete').logMessage;
  } on MissingPluginException {
    ('[Migration] native channel available nahi hai - skip').logMessage;
  } catch (e) {
    ('[Migration] error: $e').logMessage;
  }
}
void main() async {
  FlavorConfig(
      flavor: Flavor.starReward,
      flavorValues: FlavorValues(appName: "Star Reward", appVersion: "0.0.1"));
  WidgetsFlutterBinding.ensureInitialized();
  await setupNotificationStorage();
  await migratePendingNativeNotifications();
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) {
    runApp(const MyApp());
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("4272e19f-d3ec-461f-9b87-0df648b4e7bf");

    Future<String> getCurrentUserId() async {
      final sph = await SharedPreferenceHelper.getInstance();
      final user = sph.getUserData();
      return user?.id ?? 'guest';
    }

    OneSignal.Notifications.addForegroundWillDisplayListener((event) async {
      final n = event.notification;
      print(
          '[OneSignal] FOREGROUND notification received: id=${n.notificationId}, title=${n.title}');

      await migratePendingNativeNotifications();

      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((event) async {
      final n = event.notification;
      print(
          '[OneSignal] CLICKED notification: id=${n.notificationId}, title=${n.title}');

      final userId = await getCurrentUserId();

      String? imageUrl;
      if (n.bigPicture != null && n.bigPicture!.isNotEmpty) {
        imageUrl = n.bigPicture;
      } else if (n.attachments != null && n.attachments!.isNotEmpty) {
        imageUrl = n.attachments!.values.first as String?; // ✅ Map.values.first
      }

      await NotificationHiveService.markAsRead(
        id: n.notificationId ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        title: n.title ?? '',
        body: n.body ?? '',
        imageUrl: imageUrl,
        payload: n.additionalData?.toString(),
      );
    });
  });
  await _requestNotificationPermissionWeekly();
}

Future<void> _requestNotificationPermissionWeekly() async {
  print("SAVE REQUEST");
  final prefs = await SharedPreferenceHelper.getInstance();

  final lastRequestMillis = prefs.getLastNotificationTime();

  final now = DateTime.now();
  print(" LAST REQUEST: $lastRequestMillis ");
  if (lastRequestMillis != null) {
    final lastRequest = DateTime.fromMillisecondsSinceEpoch(lastRequestMillis);

    final difference = now.difference(lastRequest);
    print(" DIFFERENCE: $difference ");
    if (difference.inDays < 7) {
      print("DIFFERENCE CONDITION");
      return;
    }
  }
  if (Platform.isAndroid) {
    final canRequest = await OneSignal.Notifications.canRequest();
    print(" REQUEST PERMISSION $canRequest ");
    if (canRequest) {
      final granted = await OneSignal.Notifications.requestPermission(true);

      print("Notification permission granted: $granted");
    } else {
      print("Cannot show permission popup. Show custom UI to open settings.");
    }
  } else {
    OneSignal.Notifications.requestPermission(true);
  }

  print(" PERMISSION TIME ${now.millisecondsSinceEpoch} ");
  await prefs.saveLastNotificationTime(now.millisecondsSinceEpoch);
}

Future<void> setupNotificationStorage() async {
  await Hive.initFlutter();
  await NotificationHiveService.init();
  print('[Main] NotificationHiveService ready');
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
    WidgetsBinding.instance.addObserver(this); // 👈 register
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 👈 cleanup
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print('[Lifecycle] app resumed - checking pending native notifications');
      migratePendingNativeNotifications(); // 👈 har resume pe dobara check karo
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserLoginProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => UserInfoProvider()),
        ChangeNotifierProvider(create: (context) => PromotionsProvider()),
        ChangeNotifierProvider(create: (context) => SpecialOffersProvider()),
        ChangeNotifierProvider(create: (context) => InternetStatusProvider()),
        ChangeNotifierProvider(create: (context) => UnitedFuelsProvider()),
      ],
      child: AppBootstrap(
        child: Portal(
          child: MaterialApp(
            key: navigatorKey,
            onGenerateRoute: AppNavigator.generateRoute,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
              Locale('zh', 'CN')
            ],
            title: FlavorConfig.instance.flavorValues.appName!,
            theme: AppThemes.starRewardTheme,
            initialRoute: AppNavigator.splash,
            //home: const HomeScreen(),
            home: const SplashScreen(),
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            },
          ),
        ),
      ),
    );
  }
}
