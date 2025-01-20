import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold(
      {super.key,
      this.appBar,
      required this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppHelper.appBackground(context),
      child: Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
