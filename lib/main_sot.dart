import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:qantum_apps/view_models/DocumentScanProvider.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/view_models/InternetStatusProvider.dart';
import 'package:qantum_apps/view_models/MembershipManagerProvider.dart';
import 'package:qantum_apps/view_models/PromotionsProvider.dart';
import 'package:qantum_apps/view_models/SignupProvider.dart';
import 'package:qantum_apps/views/splash/SplashScreen.dart';

import 'core/flavors_config/app_themes.dart';
import 'core/navigation/AppNavigator.dart';

import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  FlavorConfig(
      flavor: Flavor.senseOfTaste,
      flavorValues: FlavorValues(appName: "Sense Of Taste", appVersion: "0.0.1"));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) {
    runApp(const MyApp());
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    // Initialize with your OneSignal App ID
    OneSignal.initialize("6e1d4101-fd60-4fef-83aa-1aa1c1f2f221");

    // Use this method to prompt for push notifications.
    // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
    OneSignal.Notifications.requestPermission(true);
    OneSignal.Notifications.addClickListener((onNotificationClickEvent) {
      print("NOTIFICATION PAYLOAD:: ${onNotificationClickEvent.result}");
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        ChangeNotifierProvider(create: (context) => MembershipManagerProvider()),
        ChangeNotifierProvider(create: (context) => InternetStatusProvider()),
      ],
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
          theme: AppThemes.sotTheme,
          initialRoute: AppNavigator.splash,
          home: const SplashScreen(),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!);
          },
        ),
      ),
    );
  }
}