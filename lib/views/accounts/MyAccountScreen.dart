import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/views/dialogs/ChooseFavouriteVenueDialog.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/network/APIList.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/MyAccountProvider.dart';
import '../../view_models/UserInfoProvider.dart';
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
  late SharedPreferenceHelper sharedPreferenceHelper;
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();
    flavor = FlavorConfig.instance.flavor!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      sharedPreferenceHelper = await SharedPreferenceHelper.getInstance();
    });
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 0,
        highlightElevation: 0,
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
                                  "CLICKED ONE: ${myAccountProvider.accountOptions[myAccountProvider.accountOptions.keys.elementAt(index)]!} >>> ${myAccountProvider.accountOptions.keys
                                      .elementAt(index)}");
                              if (myAccountProvider.accountOptions.keys
                                      .elementAt(index) ==
                                  "txtTermsAndConditions") {
                                "Navigate to web view".logMessage();
                                AppNavigator.navigateTo(
                                    context, AppNavigator.appWebView,
                                    arguments: APIList.TERMS_AND_CONDITIONS);
                              } else if (myAccountProvider.accountOptions.keys
                                  .elementAt(index) ==
                                  "txtChangeFavouriteVenue") {
                                ChooseFavouriteVenuedialog.getInstance()
                                    .showChooseFavouriteVenueDialog(context);
                              }else {
                                "Navigate to splash".logMessage();
                                AppNavigator.navigateTo(
                                    context,
                                    myAccountProvider.accountOptions[
                                        myAccountProvider.accountOptions.keys
                                            .elementAt(index)]!);
                              }
                            },
                          );
                        },
                        itemCount: myAccountProvider.accountOptions.length,
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Consumer<UserInfoProvider>(
                              builder: (context, provider, child) {
                            if (provider.cancelledAccount != null &&
                                provider.cancelledAccount!) {
                              /// ACCOUNT IS CANCELLED, DO LOGOUT & REDIRECT TO LOGIN SCREEN
                              /// CLEARING ALL PREFERENCES

                              sharedPreferenceHelper.clearAll();


                              /// NAVIGATING TO LOGIN SCREEN
                              Future.delayed(Duration.zero, () {
                                provider.resetCancelledAccount();
                                AppNavigator.navigateAndClearStack(
                                    context, AppNavigator.login);
                              });
                            }

                            return InkWell(
                              onTap: () async {
                                bool hasInternet =
                                    await AppHelper.checkInternetConnection();

                                if (hasInternet) {
                                  var response = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(loc.txtAlert),
                                          content: Text(loc.msgCancelAccount),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, false);
                                                },
                                                child: Text(
                                                  loc.txtNo,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                )),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(
                                                      context, true);
                                                },
                                                child: Text(
                                                  loc.txtYes,
                                                  style: TextStyle(
                                                      color: AppThemeCustom
                                                          .getAlertDialogTextButtonColor(
                                                              context)),
                                                )),
                                          ],
                                        );
                                      });

                                  if (response) {
                                    /// CANCEL ACCOUNT ///
                                    provider.cancelAccount();
                                  }
                                } else {
                                  Navigator.pop(context);
                                  AppHelper.showErrorMessage(
                                      context, loc.msgNoInternet);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      loc.txtDeleteMyAccount.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: AppThemeCustom
                                              .getDeleteMyAccountTextColor(
                                                  context)),
                                    ),
                                    AppDimens.shape_10,
                                    (provider.showCancelAccountLoader !=
                                                null &&
                                            provider.showCancelAccountLoader!)
                                        ? const SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            );
                          }))
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
