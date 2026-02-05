import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import '/view_models/DocumentScanProvider.dart';
import '/view_models/MembershipManagerProvider.dart';
import '../core/flavors_config/app_themes.dart';
import '../core/flavors_config/flavor_config.dart';
import '../core/navigation/AppNavigator.dart';
import '../views/splash/SplashScreen.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/InternetStatusProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.flinders,
      flavorValues: FlavorValues(
          appName: "Flinders Street Wharves", appVersion: "0.0.1"));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("3bd07a08-0104-47ad-b9df-39006899def4");
    await OneSignal.Notifications.requestPermission(true);
    OneSignal.Notifications.addClickListener((onNotificationClickEvent) {
      // print("NOTIFICATION PAYLOAD:: ${onNotificationClickEvent.result}");
    });

    runApp(const MyApp());

    print("Permission: ${await OneSignal.Notifications.permission}");
    var state = OneSignal.User.pushSubscription;
    print("Subscribed: ${state.optedIn}");
    print("Token: ${state.token}");
    print("Status: ${state.toString()}");
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
        ChangeNotifierProvider(create: (context) => SpecialOffersProvider()),
        ChangeNotifierProvider(create: (context) => DocumentScanProvider()),
        ChangeNotifierProvider(
            create: (context) => MembershipManagerProvider()),
        ChangeNotifierProvider(create: (context) => InternetStatusProvider()),
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
          theme: AppThemes.flindersTheme,
          initialRoute: AppNavigator.splash,
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!);
          },
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
