import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;

  const AppScaffold({super.key, this.appBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppHelper.appBackground(context),
      child: Scaffold(
        appBar: appBar,
        body: body,
      ),
    );
  }
}
