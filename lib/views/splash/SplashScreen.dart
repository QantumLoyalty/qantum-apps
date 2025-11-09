import 'package:flutter/material.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppHelper.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../common_widgets/AppLogo.dart';
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
    if (!mounted) return;
    try {
      final sharedPreferenceHelper = await SharedPreferenceHelper.getInstance();
      final hasUserData = sharedPreferenceHelper.getUserData() != null;
      if (!mounted) return;

      if (hasUserData) {
        //AppNavigator.navigateAndClearStack(context, AppNavigator.chooseMembershipScreen);
        AppNavigator.navigateAndClearStack(context, AppNavigator.home);
      } else {
        AppNavigator.navigateAndClearStack(context, AppNavigator.login);
      }
    } catch (e) {
      if (!mounted) return;
      AppNavigator.navigateAndClearStack(context, AppNavigator.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppHelper.appBackground(context),
      child: AppScaffold(
        body: Center(
            child: Applogo(
          hideTopLine: true,
        )),
      ),
    );
  }
}
