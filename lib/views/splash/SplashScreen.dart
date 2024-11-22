import 'package:flutter/material.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';

import '../../core/navigation/AppNavigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), () {
        AppNavigator.navigateReplacement(context, AppNavigator.login);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "${FlavorConfig.instance.flavorValues.appName}",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Theme.of(context).textSelectionTheme.selectionColor),
      )),
    );
  }
}
