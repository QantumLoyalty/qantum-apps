import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import 'package:qantum_apps/view_models/UserLoginProvider.dart';
import 'package:qantum_apps/views/common_widgets/AppCustomButton.dart';
import 'package:qantum_apps/views/common_widgets/AppLogo.dart';
import 'package:qantum_apps/views/common_widgets/AppScaffold.dart';

import '../../core/extensions/spacer_extension.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppLoader.dart';

class ChooseFavouriteVenueScreen extends StatefulWidget {
  Map<String, dynamic> argument;

  ChooseFavouriteVenueScreen({super.key, required this.argument});

  @override
  State<ChooseFavouriteVenueScreen> createState() =>
      _ChooseFavouriteVenueScreenState();
}

class _ChooseFavouriteVenueScreenState
    extends State<ChooseFavouriteVenueScreen> {
  late AppLocalizations loc;

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    widget.argument.toString().logMessage();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserInfoProvider>().fetchVenueList();
    });
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(body: SafeArea(
      child: Consumer2<UserInfoProvider, UserLoginProvider>(
          builder: (context, userInfoProvider, loginProvider, child) {
        if (loginProvider.isRegistered != null) {
          Future.delayed(Duration.zero, () {
            if (loginProvider.isRegistered!) {
              Map<String, String> args = {};
              args['phoneNo'] = widget.argument['phoneNo']!;
              args['countryCode'] = widget.argument['countryCode']!;
              args['userId'] = "${loginProvider.userId}";

              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppNavigator.navigateAndClearStack(context, AppNavigator.otp,
                    arguments: args);
              });
            } else {}

            loginProvider.resetUserRegisterStatus();
          });
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Applogo(
                    hideTopLine: true,
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      (userInfoProvider.venuesList != null &&
                              userInfoProvider.venuesList!.isNotEmpty)
                          ? Column(
                              children: [
                                Text(
                                  loc.selectEDPVenues,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 18,
                                  ),
                                ),
                                20.h,
              
                                /// ✅ FIX: Wrap with Expanded
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: RadioGroup<String>(
                                    groupValue: userInfoProvider.selectedVenue,
                                    onChanged: (value) {
                                      userInfoProvider.selectVenue(value!);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        children:
                                            userInfoProvider.venuesList!.map((item) {
                                          return RadioListTile<String>(
                                              value: item.name!,
                                              title: Text(item.name ?? "",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  )));
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            )
                          : const SizedBox.shrink(),
                      userInfoProvider.showVenuesListLoader != null &&
                              userInfoProvider.showVenuesListLoader!
                          ? AppLoader()
                          : const SizedBox.shrink(),
                      loginProvider.showLoader
                          ? AppLoader(
                              loaderMessage: loc.msgPleaseWait,
                            )
                          : Container()
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 20, bottom: 20),
                    child: AppCustomButton(
                      text: loc.txtSaveMyVenue.toString(),
                      textColor: AppHelper.getAccountsButtonTextColor(context),
                      onClick: () {
                        if (userInfoProvider.selectedVenue != null &&
                            userInfoProvider.selectedVenue!.isNotEmpty) {
                          String phoneNo =
                              "${widget.argument['countryCode']}${widget.argument['phoneNo']}";
                          widget.argument["venueName"] =
                              userInfoProvider.selectedVenue!;
                          loginProvider.signup(phoneNo, widget.argument, loc: loc);
                        } else {
                          AppHelper.showErrorMessage(context, loc.selectEDPVenues);
                        }
                      },
                      style: AppHelper.getAccountsButtonStyle(context),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.chevron_left,
                      size: 28,
                      color:
                      AppThemeCustom.getAccountHeaderColor(context),
                    ),
                  )),
            ),
          ],
        );
      }),
    ));
  }
}
