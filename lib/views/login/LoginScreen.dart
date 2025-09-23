import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../views/dialogs/ErrorDialog.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../view_models/UserLoginProvider.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  String countryCode = "+61";
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();

  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      body: SafeArea(
        child: Consumer<UserLoginProvider>(builder: (context, provider, child) {
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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.navigateReplacement(context, AppNavigator.signup,
                      arguments: args);
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
                /* WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppHelper.showErrorMessage(
                      context, provider.networkMessage ?? "");
                });*/
                ErrorDialog.getInstance().showErrorDialog(context,
                    message: provider.networkMessage ??
                        loc.msgCommonError);
              }
              /* else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppHelper.showSuccessMessage(
                      context, provider.networkMessage ?? "");
                });
              }*/

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
                              loc.txtWelcome,
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
                              child: Text(
                                  loc.txtMobileNumber,
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
                                      color: Theme.of(context).dividerColor),
                                  color: AppThemeCustom.getTextFieldBackground(
                                      context),
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
                                        color: Theme.of(context)
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
                                        width: 0.2,
                                        thickness: 0.2,
                                        color: Theme.of(context).dividerColor,
                                      )),
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
                                                .getTextFieldTextColor(
                                                    context)),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: "0400000000",
                                          hintStyle: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor),
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
                            AppDimens.getCustomBoxShape(30),
                            AppButton(
                              text: loc
                                  .txtOk
                                  .toUpperCase(),
                              onClick: () {
                                if (_phoneController.text.isNotEmpty &&
                                    AppHelper.verifyPhoneNumber(
                                        _phoneController.text)) {
                                  provider.login(
                                      "$countryCode${_phoneController.text}");
                                } else {
                                  AppHelper.showErrorMessage(context,
                                      loc.msgIncorrectPhoneNumber);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppDimens.shape_10,
                    InkWell(
                      onTap: () {
                        AppNavigator.navigateTo(
                            context, AppNavigator.recoverAccountScreen);
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: /*RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Change",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .onPrimary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14)),
                          TextSpan(
                              text: " my mobile",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .onPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ])),*/
                              RichText(
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
                color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 14)), // text before
      TextSpan(
        text: loc.txtChange, // translated "Change" (बदलें / 更改 / Change)
        style: TextStyle(
            color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 14),
      ),
      if (parts.length > 1)
        TextSpan(
            text: parts[1],
            style: TextStyle(
                color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 14)), // text after
    ];
  }
}
