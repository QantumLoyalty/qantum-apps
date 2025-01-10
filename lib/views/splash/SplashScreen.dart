import 'package:flutter/material.dart';

import '../../core/flavors_config/flavor_config.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppHelper.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../common_widgets/AppScaffold.dart';

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
      Future.delayed(const Duration(seconds: 2), () {
        _checkLoginStatus();
      });
    });
  }

  _checkLoginStatus() async {
    if (context.mounted) {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      if (sharedPreferenceHelper.getUserData() != null) {
        AppNavigator.navigateAndClearStack(context, AppNavigator.home);
      } else {
        AppNavigator.navigateAndClearStack(context, AppNavigator.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppHelper.appBackground(context),
      child: AppScaffold(
        body: Center(
            child: Text(
          "${FlavorConfig.instance.flavorValues.appName}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        )),
      ),
    );
  }
}
