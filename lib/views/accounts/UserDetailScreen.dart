import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../common_widgets/BluewaterBackground.dart';
import '/l10n/app_localizations.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppHelper.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppCustomButton.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';
import 'widgets/DetailCard.dart';
import 'widgets/PhoneCard.dart';
import 'widgets/RecoveryEmailCard.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late SharedPreferenceHelper _sharedPreferenceHelper;
  late AppLocalizations loc;
  late Flavor flavor;

  @override
  void initState() {
    super.initState();
    initSharedPreferenceHelper();
    flavor = FlavorConfig.instance.flavor!;
  }

  initSharedPreferenceHelper() async {
    _sharedPreferenceHelper = await SharedPreferenceHelper.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(showBackButton: true, title: loc.txtChangeMyDetails),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  top: 25, left: 15, right: 15, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context).canvasColor,
              ),
              child: Consumer<UserInfoProvider>(
                  builder: (context, provider, child) {
                if (provider.cancelledAccount != null) {
                  if (provider.cancelledAccount!) {
                    /// ACCOUNT IS CANCELLED, DO LOGOUT & REDIRECT TO LOGIN SCREEN
                    /// CLEARING ALL PREFERENCES

                    _sharedPreferenceHelper.clearAll();

                    /// NAVIGATING TO LOGIN SCREEN
                    Future.delayed(Duration.zero, () {
                      provider.resetCancelledAccount();
                      AppNavigator.navigateAndClearStack(
                          context, AppNavigator.login);
                    });
                  } else {
                    AppHelper.showErrorMessage(
                        context, provider.networkMessage ?? loc.msgCommonError);
                  }
                }

                return Stack(
                  children: [
                    flavor == Flavor.bluewater
                        ? const BluewaterBackground()
                        : Container(),
                    Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                DetailCard(
                                  editable: false,
                                ),
                                AppDimens.shape_10,
                                RecoveryEmailCard(
                                  editable: false,
                                ),
                                AppDimens.shape_10,
                                PhoneCard(editable: false),
                                AppDimens.shape_30,
                                AppCustomButton(
                                  text: loc.txtEditAccountDetails.toUpperCase(),
                                  textColor:
                                      AppHelper.getAccountsButtonTextColor(
                                          context),
                                  icon: Icon(
                                    Icons.open_in_new,
                                    color: AppHelper.getAccountsButtonTextColor(
                                        context),
                                    size: 18,
                                  ),
                                  onClick: () async {
                                    bool hasInternet = await AppHelper
                                        .checkInternetConnection();

                                    if (hasInternet) {
                                      AppNavigator.navigateTo(context,
                                          AppNavigator.verifyOTPAccount);
                                    } else {
                                      AppHelper.showErrorMessage(
                                          context, loc.msgNoInternet);
                                    }
                                  },
                                  style:
                                      AppHelper.getAccountsButtonStyle(context),
                                )
                              ],
                            ),
                          ),
                        ),
                        AppDimens.shape_20,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AppCustomButton(
                            style: AppHelper.getDeleteButtonStyle(context),
                            onClick: () async {
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
                                                Navigator.pop(context, false);
                                              },
                                              child: Text(
                                                loc.txtNo,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context, true);
                                              },
                                              child: Text(loc.txtYes,
                                                  style: TextStyle(
                                                      color: AppThemeCustom
                                                          .getAlertDialogTextButtonColor(
                                                              context)))),
                                        ],
                                      );
                                    });

                                if (response) {
                                  /// CANCEL ACCOUNT ///
                                  provider.cancelAccount();
                                }
                              } else {
                                AppHelper.showErrorMessage(
                                    context, loc.msgNoInternet);
                              }
                            },
                            text: loc.txtDeleteMyAccount.toUpperCase(),
                            textColor:
                                AppThemeCustom.getAccountSectionDeleteTextStyle(
                                    context),
                          ),
                        ),
                        AppDimens.shape_20,
                      ],
                    ),
                    provider.showCancelAccountLoader != null &&
                            provider.showCancelAccountLoader!
                        ? AppLoader(
                            loaderMessage: loc.loadermsgCancelAccount,
                          )
                        : Container()
                  ],
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
