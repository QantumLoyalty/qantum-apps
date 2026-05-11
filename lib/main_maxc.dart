import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/DocumentScanProvider.dart';
import 'package:qantum_apps/view_models/MembershipManagerProvider.dart';
import 'view_models/InternetStatusProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'core/flavors_config/app_themes.dart';
import 'core/flavors_config/flavor_config.dart';
import 'core/navigation/AppNavigator.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/UnitedFuelsProvider.dart' show UnitedFuelsProvider;
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'views/splash/SplashScreen.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      flavor: Flavor.maxClub,
      flavorValues: FlavorValues(appName: "Max Club", appVersion: "0.0.1"));

  await dotenv.load(fileName: '.env.maxc');
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) {
    runApp(const MyApp());
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    // Initialize with your OneSignal App ID
    OneSignal.initialize("bc03a2c3-74a6-466f-b4c0-350b70a4d007");
    // Use this method to prompt for push notifications.
    // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
    OneSignal.Notifications.requestPermission(true);
    OneSignal.Notifications.addClickListener((onNotificationClickEvent) {
      // print("NOTIFICATION PAYLOAD:: ${onNotificationClickEvent.result}");
    });
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
    Stripe.stripeAccountId = dotenv.env['STRIPE_CONNECTED_ACCOUNT_ID'] ?? '';
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
        theme: AppThemes.maxTheme,
        initialRoute: AppNavigator.splash,
        home: const SplashScreen(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.0)),
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light),
                  child: child ?? const SizedBox())
          );
        },
      )),
    );
  }
}
