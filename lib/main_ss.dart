import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/data/local/SharedPreferenceHelper.dart';
import 'package:qantum_apps/data/models/notification_model.dart';
import 'package:qantum_apps/services/notification_services.dart';
import 'package:qantum_apps/view_models/DocumentScanProvider.dart';
import 'package:qantum_apps/view_models/InternetStatusProvider.dart';
import 'package:qantum_apps/view_models/MembershipManagerProvider.dart';
import 'package:qantum_apps/view_models/UnitedFuelsProvider.dart';

import 'core/flavors_config/app_themes.dart';
import 'core/flavors_config/flavor_config.dart';
import 'core/navigation/AppNavigator.dart';
import 'l10n/app_localizations.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';

Future<void> syncCurrentUserIdToNative(String userId) async {
  try {
    await _nativeNotificationsChannel
        .invokeMethod('setCurrentUserId', {'userId': userId});
    print('[NativeSync] userId synced to App Group: $userId');
  } on MissingPluginException {
    // Android - normal, skip
  } catch (e) {
    print('[NativeSync] error: $e');
  }
}

const MethodChannel _nativeNotificationsChannel =
    MethodChannel('com.qantum/native_notifications');

Future<void> migratePendingNativeNotifications() async {
  try {
    final List<dynamic>? pendingList = await _nativeNotificationsChannel
        .invokeMethod('getPendingNotifications');

    if (pendingList == null || pendingList.isEmpty) {
      print('[Migration] koi pending native notification nahi mila');
      return;
    }

    print(
        '[Migration] ${pendingList.length} pending notifications mile, Hive me migrate kar rahe hain');

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
      } catch (e) {
        print(
            '[Migration] ek notification parse karne me error: $e, raw: $item');
      }
    }

    print('[Migration] migration complete');
  } on MissingPluginException {
    print('[Migration] native channel available nahi hai - skip');
  } catch (e) {
    print('[Migration] error: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
      flavor: Flavor.southportSharks,
      flavorValues:
          FlavorValues(appName: "Southport Sharks", appVersion: "0.0.1"));

  await dotenv.load(fileName: '.env.ss');

  await setupNotificationStorage(); // <-- NAYI LINE
  await migratePendingNativeNotifications(); // 👈 YE NAYI LINE

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) async {
    // <-- async karna padega
    runApp(const MyApp());
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("668011af-5fa3-4785-8486-d63a7bf5d644");
    OneSignal.Notifications.requestPermission(true);

    Future<String> _getCurrentUserId() async {
      final sph = await SharedPreferenceHelper.getInstance();
      final user = sph.getUserData();
      return user?.id ?? 'guest';
    }

    // FOREGROUND — notification aayi aur app foreground me hai
    OneSignal.Notifications.addForegroundWillDisplayListener((event) async {
      final n = event.notification;
      print(
          '[OneSignal] FOREGROUND notification received: id=${n.notificationId}, title=${n.title}');

      if (Platform.isIOS) {
        await migratePendingNativeNotifications();
      } else {
        // Android: NSE hai hi nahi, isliye purana direct-save logic yahi rahega
        final userId = await _getCurrentUserId();

        String? imageUrl;
        if (n.bigPicture != null && n.bigPicture!.isNotEmpty) {
          imageUrl = n.bigPicture;
        } else if (n.attachments != null && n.attachments!.isNotEmpty) {
          imageUrl = n.attachments!.values.first as String?;
        }

        final model = NotificationModel(
          id: n.notificationId ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          userId: userId,
          title: n.title ?? '',
          body: n.body ?? '',
          imageUrl: imageUrl,
          payload: n.additionalData?.toString(),
          isRead: false,
          receivedAt: DateTime.now(),
        );

        await NotificationHiveService.save(model);
      }

      event.notification.display();
    });

    // TAP — foreground/background/terminated teeno me kaam karega
    OneSignal.Notifications.addClickListener((event) async {
      final n = event.notification;
      print(
          '[OneSignal] CLICKED notification: id=${n.notificationId}, title=${n.title}');

      final userId = await _getCurrentUserId();

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

    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
    Stripe.stripeAccountId = dotenv.env['STRIPE_CONNECTED_ACCOUNT_ID'] ?? '';
    Stripe.instance.applySettings();
  });
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
        ChangeNotifierProvider(create: (context) => DocumentScanProvider()),
        ChangeNotifierProvider(
            create: (context) => MembershipManagerProvider()),
        ChangeNotifierProvider(create: (context) => InternetStatusProvider()),
        ChangeNotifierProvider(create: (context) => UnitedFuelsProvider()),
      ],
      child: Portal(
        child: MaterialApp(
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
          theme: AppThemes.southportSharksTheme,
          initialRoute: AppNavigator.splash,
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        statusBarBrightness: Brightness.dark,
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Brightness.light),
                    child: child ?? const SizedBox()));
          },
        ),
      ),
    );
  }
}
