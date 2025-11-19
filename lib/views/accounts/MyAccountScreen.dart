import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppHelper.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/MyAccountProvider.dart';
import '../common_widgets/AppScaffold.dart';
import '../common_widgets/BluewaterBackground.dart';
import 'widgets/AccountsAppBar.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  MyAccountProvider myAccountProvider = MyAccountProvider();
  late Flavor flavor;

  @override
  void initState() {
    super.initState();
    flavor = FlavorConfig.instance.flavor!;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.clear,
          size: 30,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => myAccountProvider,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AccountsAppBar(
                  showBackButton: false,
                  title: AppLocalizations.of(context)!.txtMyAccount),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Theme.of(context).canvasColor),
                  child: Stack(
                    children: [
                      flavor == Flavor.bluewater
                          ? const BluewaterBackground()
                          : Container(),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              myAccountProvider.getTranslatedText(
                                  AppLocalizations.of(context)!,
                                  myAccountProvider.accountOptions.keys
                                      .elementAt(index)),
                              style: TextStyle(
                                  color:
                                      AppThemeCustom.getAccountSectionItemStyle(
                                          context),
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(Icons.chevron_right,
                                color:
                                    AppThemeCustom.getAccountSectionItemStyle(
                                        context)),
                            onTap: () {
                              AppHelper.printMessage(
                                  myAccountProvider.accountOptions[
                                      myAccountProvider.accountOptions.keys
                                          .elementAt(index)]!);
                              AppNavigator.navigateTo(
                                  context,
                                  myAccountProvider.accountOptions[
                                      myAccountProvider.accountOptions.keys
                                          .elementAt(index)]!);
                            },
                          );
                        },
                        itemCount: myAccountProvider.accountOptions.length,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myAccountProvider.dispose();
  }
}
