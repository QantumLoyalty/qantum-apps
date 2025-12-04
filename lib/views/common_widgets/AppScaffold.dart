import 'package:flutter/material.dart';
import 'package:qantum_apps/views/common_widgets/BluewaterScaffoldBackground.dart';
import '/core/flavors_config/flavor_config.dart';
import '../../core/utils/AppHelper.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? scaffoldBackground;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  Flavor? flavor;

  AppScaffold(
      {super.key,
      this.appBar,
      required this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.scaffoldBackground});

  @override
  Widget build(BuildContext context) {
    flavor ??= FlavorConfig.instance.flavor;

    return Container(
      decoration: AppHelper.appBackground(context),
      child: Stack(
        children: [
          (flavor == Flavor.bluewater)
              ? const BluewaterScaffoldBackground()
              : Container(),
          Scaffold(
            appBar: appBar,
            body: body,
            //  backgroundColor: Colors.transparent,
            backgroundColor: scaffoldBackground ?? Colors.transparent,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
          ),
          (flavor == Flavor.aceRewards)
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Opacity(
                        opacity: 0.4,
                        child: Image.asset(
                            "assets/aceRewards/scaffold_background.png")),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
