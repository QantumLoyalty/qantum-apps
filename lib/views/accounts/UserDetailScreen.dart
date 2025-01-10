import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppButton.dart';
import 'widgets/AccountsAppBar.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
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
                color: Theme.of(context).primaryColor,
              ),
              child: Consumer<UserInfoProvider>(
                  builder: (context, provider, child) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.white.withValues(alpha: 0.2),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.txtMyDetails.toUpperCase(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .primary),
                                      ),
                                      AppDimens.shape_5,
                                      Text(
                                        "${provider.getUserInfo != null && provider.getUserInfo!.firstName != null ? provider.getUserInfo!.firstName : ""} ${(provider.getUserInfo != null && provider.getUserInfo!.lastName != null && provider.getUserInfo!.lastName!.length > 2) ? provider.getUserInfo!.lastName!.replaceRange(1, provider.getUserInfo!.lastName!.length, "*" * provider.getUserInfo!.lastName!.length) : ""}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                                      Text(
                                        "DOB **/**/****",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AppDimens.shape_10,
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.white.withValues(alpha: 0.2),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.txtRecoveryEmail
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .primary),
                                      ),
                                      AppDimens.shape_5,
                                      Text(
                                        AppHelper.maskEmail(
                                            provider.getUserInfo!.email),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AppDimens.shape_10,
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.white.withValues(alpha: 0.2),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.txtMobileNumber
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .primary),
                                      ),
                                      AppDimens.shape_5,
                                      Text(
                                        AppHelper.maskPhoneNumber(
                                            provider.getUserInfo!.mobile!),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                onClick: () {})
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
                          onPressed: () {},
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
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
