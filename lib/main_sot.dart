import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/view_models/SignupProvider.dart';
import 'package:qantum_apps/views/splash/SplashScreen.dart';

import 'core/flavors_config/app_themes.dart';
import 'core/navigation/AppNavigator.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';

//TextTheme? textTheme;
void main() async {
  FlavorConfig(
      flavor: Flavor.senseOfTaste,
      flavorValues:
          FlavorValues(appName: "Sense Of Taste", appVersion: "0.0.1"));
//  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((context) {
    runApp(const MyApp());
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
        ChangeNotifierProvider(create: (context) => SpecialOffersProvider())
      ],
      child: Portal(
        child: MaterialApp(
          onGenerateRoute: AppNavigator.generateRoute,
          debugShowCheckedModeBanner: false,
          title: FlavorConfig.instance.flavorValues.appName!,
          theme: AppThemes.sotTheme,
          // theme: AppThemes.sotTheme.copyWith(textTheme: textTheme!),

          initialRoute: AppNavigator.splash,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
