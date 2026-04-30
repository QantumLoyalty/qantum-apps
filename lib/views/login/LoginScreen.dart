import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/core/utils/DeepLinkLauncher.dart';

import '../../view_models/HomeProvider.dart';
import '/core/flavors_config/flavor_config.dart';
import '/l10n/app_localizations.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../view_models/UserLoginProvider.dart';
import '../../views/dialogs/ErrorDialog.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class LoginScreen extends StatefulWidget {
  bool? hideChangeMobileOption;

  LoginScreen({super.key, this.hideChangeMobileOption});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  String countryCode = "+61";
  late AppLocalizations loc;
  late Flavor flavor;
  bool _chewzieGuestHandled = false;
  late HomeProvider _homeProvider;
  //late Color toolbarColor;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    flavor = FlavorConfig.instance.flavor!;
    //toolbarColor = Theme.of(context).primaryColor;
    _homeProvider = context.read<HomeProvider>();
    _homeProvider.addListener(_handleGuestChewzieFromProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleGuestChewzieFromProvider();
    });
  }

/*  void _handleGuestChewzieFromProvider() {
    if (!mounted) return;
    if (_chewzieGuestHandled) return;
    if (flavor != Flavor.starReward) return;

    final homeProvider = context.read<HomeProvider>();

    if (homeProvider.startChewzieScreen != true) return;
    if (homeProvider.deeplinkPayloads == null ||
        homeProvider.deeplinkPayloads!.isEmpty) {
      return;
    }

    _chewzieGuestHandled = true;

    final payload = homeProvider.consumeChewzieLink();
    if (payload == null || payload.isEmpty) return;

    final decodedLink = Uri.decodeComponent(payload);
    final uri = Uri.parse(decodedLink);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;

        final routeIsCurrent = ModalRoute.of(context)?.isCurrent ?? false;
        if (!routeIsCurrent) return;

        debugPrint("LOGIN GUEST CHEWZIE URI: $uri");
        DeepLinkLauncher.launchChewzieUrl(context, uri);
      });
    });
  }*/
  void _handleGuestChewzieFromProvider() {
    if (!mounted) return;
    if (_chewzieGuestHandled) return;
    if (flavor != Flavor.starReward) return;

    if (_homeProvider.startChewzieScreen != true) return;

    final payload = _homeProvider.deeplinkPayloads;
    if (payload == null || payload.isEmpty) return;

    _chewzieGuestHandled = true;

    final consumedPayload = _homeProvider.consumeChewzieLink();
    if (consumedPayload == null || consumedPayload.isEmpty) return;

    final decodedLink = Uri.decodeComponent(consumedPayload);
    final uri = Uri.parse(decodedLink);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(milliseconds: Platform.isIOS ? 700 : 300),
        () {
          if (!mounted) return;

          debugPrint("LOGIN GUEST CHEWZIE URI: $uri");
          DeepLinkLauncher.launchChewzieUrl(context, uri, AppColors.sr_back_color);
        },
      );
    });
  }

  @override
  void dispose() {
    context
        .read<HomeProvider>()
        .removeListener(_handleGuestChewzieFromProvider);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      body: SafeArea(
        child: Consumer2<UserLoginProvider, HomeProvider>(
            builder: (context, provider, homeProvider, child) {


          /// HANDLING GUEST USERS FOR CHEWZEE CASE
/*
          if (!_chewzieGuestHandled &&
              flavor == Flavor.starReward &&
              homeProvider.deeplinkPayloads != null &&
              homeProvider.deeplinkPayloads!.isNotEmpty) {
            _chewzieGuestHandled = true;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;

              final decodedLink =
                  Uri.decodeComponent(homeProvider.deeplinkPayloads!);
              final uri = Uri.parse(decodedLink);

              homeProvider.resetDeepLinkNavigation();

              Future.delayed(const Duration(milliseconds: 700), () {
                if (!mounted) return;

                final routeIsCurrent =
                    ModalRoute.of(context)?.isCurrent ?? false;
                if (!routeIsCurrent) return;

                "DEEP LINK URI: $uri".logMessage();
                DeepLinkLauncher.launchChewzieUrl(context, uri);
              });
            });
          }
*/

          /// CHECKING USER STATUS & NAVIGATING AS PER THE STATUS
          if (provider.isExistingUser != null) {
            Future.delayed(Duration.zero, () {
              if (provider.isExistingUser!) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Map<String, String> args = {};
                  args['countryCode'] = countryCode;
                  args['phoneNo'] = _phoneController.text.toString();
                  args['userId'] = "${provider.userId}";
                  AppNavigator.navigateTo(context, AppNavigator.otp,
                      arguments: args);
                });
              } else {
                Map<String, String> args = {};
                args['countryCode'] = countryCode;
                args['phoneNo'] = _phoneController.text.toString();
                //////////////////////////////
                //// SPECIAL CASE FOR APPSTORE REVIEW ////
                if (provider.userId != null) {
                  args['userId'] = "${provider.userId}";
                  args['isTestUser'] = "true";
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (AppHelper.isClubApp()) {
                    AppNavigator.navigateReplacement(
                        context, AppNavigator.drivingLicenseScreen,
                        arguments: args);
                  } else {
                    AppNavigator.navigateReplacement(
                        context, AppNavigator.signup,
                        arguments: args);
                  }
                });
              }

              provider.resetUserStatus();
            });
          }

          /// DISPLAYING NETWORK RESPONSE
          if (provider.networkError != null &&
              provider.networkMessage != null) {
            Future.delayed(Duration.zero, () {
              if (provider.networkError!) {
                ErrorDialog.getInstance().showErrorDialog(context,
                    message: provider.networkMessage ?? loc.msgCommonError);
              }
              provider.resetNetworkResponseStatus();
            });
          }

          return Container(
            padding: const EdgeInsets.all(AppDimens.screenPadding),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Applogo(),
                            Text(
                              loc.txtWelcome.toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            AppDimens.shape_10,
                            Text(
                              loc.txtEnterYourNumber,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            AppDimens.shape_30,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(loc.txtMobileNumber,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  )),
                            ),
                            AppDimens.shape_10,
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color: AppThemeCustom
                                          .getContainerBorderColor(context)),
                                  color: AppThemeCustom.getTextFieldBackground(
                                      context,
                                      isShadow: true),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CountryCodePicker(
                                    favorite: const ["AU", "IN"],
                                    closeIcon: Icon(
                                      Icons.close,
                                      color: AppColors.black,
                                    ),
                                    textStyle: TextStyle(
                                        color: flavor == Flavor.kingscliff
                                            ? AppColors.white
                                            : Theme.of(context)
                                                .textSelectionTheme
                                                .selectionHandleColor),
                                    onChanged: (code) {
                                      setState(() {
                                        countryCode = code.dialCode!;
                                        AppHelper.printMessage(
                                            "Selected country::${code.dialCode}");
                                      });
                                    },
                                    initialSelection: "AU",
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: VerticalDivider(
                                        width: 1,
                                        thickness: 1,
                                        color: AppThemeCustom
                                            .getTextFormFieldInnerDividerColor(
                                          context,
                                        )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        maxLines: 1,
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: _phoneController,
                                        style: TextStyle(
                                            color: AppThemeCustom
                                                .getTextFieldTextColor(context,
                                                    isShadow: true)),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: "0400000000",
                                          hintStyle: TextStyle(
                                              color: AppThemeCustom
                                                  .getHintTextFieldColor(
                                                      context,
                                                      isShadow: true)),
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppDimens.getCustomBoxShape(20),
                            AppButton(
                              text: loc.txtOk.toUpperCase(),
                              onClick: () {
                                if (_phoneController.text.isNotEmpty &&
                                    AppHelper.verifyPhoneNumber(
                                        _phoneController.text)) {
                                  provider.login(
                                      "$countryCode${_phoneController.text}",
                                      context);
                                } else {
                                  AppHelper.showErrorMessage(
                                      context, loc.msgIncorrectPhoneNumber);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppDimens.shape_10,
                    (widget.hideChangeMobileOption != null &&
                            widget.hideChangeMobileOption!)
                        ? Container()
                        : InkWell(
                            onTap: () {
                              AppNavigator.navigateTo(
                                  context, AppNavigator.recoverAccountScreen);
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 5),
                                child: RichText(
                                    text: TextSpan(
                                        children: _buildLocalizedChangeMyMobile(
                                            context)))),
                          ),
                    AppDimens.shape_10,
                  ],
                ),
                provider.showLoader
                    ? AppLoader(
                        loaderMessage: loc.msgVerifyAccountAndProceed,
                      )
                    : Container()
              ],
            ),
          );
        }),
      ),
    );
  }

/*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final homeProvider = context.watch<HomeProvider>();

    if (_chewzieGuestHandled) return;
    if (flavor != Flavor.starReward) return;
    if (homeProvider.startChewzieScreen != true) return;
    if (homeProvider.deeplinkPayloads == null) return;

    _chewzieGuestHandled = true;

    final payload = homeProvider.consumeChewzieLink();
    if (payload == null || payload.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final decodedLink = Uri.decodeComponent(payload);
      final uri = Uri.parse(decodedLink);

      DeepLinkLauncher.launchChewzieUrl(context, uri);
    });
  }*/

  List<TextSpan> _buildLocalizedChangeMyMobile(BuildContext context) {
    // Use a temporary marker where the bold word should go
    final template = loc.txtChangeMyMobile("§§");

    // Split the string into parts
    final parts = template.split("§§");

    return [
      if (parts.isNotEmpty)
        TextSpan(
            text: parts[0],
            style: TextStyle(
                color: (flavor == Flavor.bobsBulkBooze ||
                        flavor == Flavor.senseOfTaste ||
                        flavor == Flavor.drinkRewards)
                    ? Theme.of(context).buttonTheme.colorScheme!.onSecondary
                    : Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 14)), // text before
      TextSpan(
        text: loc.txtChange, // translated "Change" (बदलें / 更改 / Change)
        style: TextStyle(
            color: (flavor == Flavor.bobsBulkBooze ||
                    flavor == Flavor.senseOfTaste ||
                    flavor == Flavor.drinkRewards)
                ? Theme.of(context).buttonTheme.colorScheme!.onSecondary
                : Theme.of(context).buttonTheme.colorScheme!.onPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 14),
      ),
      if (parts.length > 1)
        TextSpan(
            text: parts[1],
            style: TextStyle(
                color: (flavor == Flavor.bobsBulkBooze ||
                        flavor == Flavor.senseOfTaste ||
                        flavor == Flavor.drinkRewards)
                    ? Theme.of(context).buttonTheme.colorScheme!.onSecondary
                    : Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 14)), // text after
    ];
  }
}
