import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_themes.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/views/splash/SplashScreen.dart';
import 'view_models/HomeProvider.dart';
import 'view_models/SignupProvider.dart';
import 'view_models/SpecialOffersProvider.dart';
import 'view_models/UserInfoProvider.dart';
import 'view_models/UserLoginProvider.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.starReward,
      flavorValues: FlavorValues(appName: "Star Reward", appVersion: "0.0.1"));
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
        ChangeNotifierProvider(create: (context) => SpecialOffersProvider())
      ],
      child: Portal(
        child: MaterialApp(
          onGenerateRoute: AppNavigator.generateRoute,
          debugShowCheckedModeBanner: false,
          title: FlavorConfig.instance.flavorValues.appName!,
          theme: AppThemes.starRewardTheme,
          initialRoute: AppNavigator.splash,
          //home: const HomeScreen(),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
