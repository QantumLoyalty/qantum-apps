
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'view_models/DocumentScanProvider.dart';
import 'view_models/MembershipManagerProvider.dart';
import 'core/flavors_config/app_themes.dart';
import 'core/flavors_config/flavor_config.dart';
import 'core/navigation/AppNavigator.dart';
import 'core/navigation/route_observer.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'views/splash/SplashScreen.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      flavor: Flavor.qantumClub,
      flavorValues: FlavorValues(appName: "Qantum", appVersion: "0.0.1"));

  await dotenv.load(fileName: '.env.qantum');
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) {
    runApp(const MyApp());
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    // Initialize with your OneSignal App ID
    OneSignal.initialize("c2e3ab66-0907-4413-83a9-97fe94ccfdb9");
    // Use this method to prompt for push notifications.
    // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
    OneSignal.Notifications.requestPermission(true);
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
    Stripe.instance.applySettings();
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
      ],
      child: Portal(
          child: MaterialApp(
        onGenerateRoute: AppNavigator.generateRoute,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
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
        theme: AppThemes.qantumTheme,
        initialRoute: AppNavigator.splash,
        //home: const HomeScreen(),
        home: const SplashScreen(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!);
        },
      )),
    );
  }
}
