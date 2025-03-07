import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'core/flavors_config/app_themes.dart';
import 'core/flavors_config/flavor_config.dart';
import 'core/navigation/AppNavigator.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/PromotionsProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';
import 'views/splash/SplashScreen.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.maxx,
      flavorValues: FlavorValues(appName: "Max", appVersion: "0.0.1"));
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  runApp(const MyApp());
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
        ChangeNotifierProvider(create: (context) => SpecialOffersProvider())
      ],
      child: Portal(
          child: MaterialApp(
        onGenerateRoute: AppNavigator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: FlavorConfig.instance.flavorValues.appName!,
        theme: AppThemes.maxTheme,
        initialRoute: AppNavigator.splash,
        //home: const HomeScreen(),
        home: const SplashScreen(),
      )),
    );
  }
}
