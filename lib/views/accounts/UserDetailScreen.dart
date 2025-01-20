import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/local/SharedPreferenceHelper.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppScaffold.dart';
import '../dialogs/ErrorDialog.dart';
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

  @override
  void initState() {
    super.initState();
    initSharedPreferenceHelper();
  }

  initSharedPreferenceHelper() async {
    _sharedPreferenceHelper = await SharedPreferenceHelper.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true, title: AppStrings.txtChangeMyDetails),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme!
                    .primary
                    .withValues(alpha: 0.2),
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
                        context,
                        provider.networkMessage ??
                            "Ooppss.. something went wrong, please try again.");
                  }
                }

                return Stack(
                  children: [
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
                                AppButton(
                                    text: AppStrings.txtEditAccountDetails
                                        .toUpperCase(),
                                    icon: Icon(
                                      Icons.open_in_new,
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .onPrimary,
                                      size: 18,
                                    ),
                                    onClick: () {
                                      AppNavigator.navigateTo(context,
                                          AppNavigator.verifyOTPAccount);
                                    })
                              ],
                            ),
                          ),
                        ),
                        AppDimens.shape_20,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .primary)),
                              onPressed: () async {
                                var response = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(AppStrings.txtAlert),
                                        content: const Text(
                                            AppStrings.msgCancelAccount),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child:
                                                  const Text(AppStrings.txtNo)),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context, true);
                                              },
                                              child: const Text(
                                                  AppStrings.txtYes)),
                                        ],
                                      );
                                    });

                                if (response) {
                                  /// CANCEL ACCOUNT ///
                                  provider.cancelAccount();
                                }
                              },
                              child: Text(
                                AppStrings.txtDeleteMyAccount.toUpperCase(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                              )),
                        ),
                        AppDimens.shape_20,
                      ],
                    ),
                    provider.showCancelAccountLoader != null &&
                            provider.showCancelAccountLoader!
                        ? AppLoader(
                            loaderMessage: AppStrings.loadermsgCancelAccount,
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
