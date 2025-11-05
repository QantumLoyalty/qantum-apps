import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import '../core/flavors_config/app_themes.dart';
import '../core/flavors_config/flavor_config.dart';
import '../core/navigation/AppNavigator.dart';
import '../views/splash/SplashScreen.dart';
import 'l10n/app_localizations.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.montaukTavern,
      flavorValues:
          FlavorValues(appName: "Montauk  Tavern", appVersion: "0.0.1"));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) {
    runApp(const MyApp());
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    // Initialize with your OneSignal App ID
    OneSignal.initialize("74975aaa-c169-4ae7-b18e-f887819b0d3c");
    // Use this method to prompt for push notifications.
    // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
    OneSignal.Notifications.requestPermission(true);
    OneSignal.Notifications.addClickListener((onNotificationClickEvent) {
      print("NOTIFICATION PAYLOAD:: ${onNotificationClickEvent.result}");
    });
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
        ChangeNotifierProvider(create: (context) => SpecialOffersProvider())
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
          theme: AppThemes.montaukTavernTheme,
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
    );
  }
}
