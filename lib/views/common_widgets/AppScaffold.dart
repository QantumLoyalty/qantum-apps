import 'package:flutter/material.dart';

import '../../core/utils/AppHelper.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? scaffoldBackground;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold(
      {super.key,
      this.appBar,
      required this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.scaffoldBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppHelper.appBackground(context),
      child: Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: scaffoldBackground ?? Colors.transparent,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
