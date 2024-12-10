import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_themes.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/views/GeoFenceSample.dart';
import 'package:qantum_apps/views/PushnotificationSample.dart';
import 'package:qantum_apps/views/splash/SplashScreen.dart';

import 'view_models/HomeProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/UserLoginProvider.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.starReward,
      flavorValues: FlavorValues(appName: "Star Reward", appVersion: "0.0.1"));

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
        ChangeNotifierProvider(create: (context) => SignupProvider())
      ],
      child: MaterialApp(
        onGenerateRoute: AppNavigator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: FlavorConfig.instance.flavorValues.appName!,
        theme: AppThemes.starRewardTheme,
        initialRoute: AppNavigator.splash,
        //home: const PushnotificationSample(),
        home: const SplashScreen(),
      ),
    );
  }
}
