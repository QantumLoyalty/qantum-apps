import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/UserLoginProvider.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class OTPScreen extends StatefulWidget {
  Map<String, String> argument;

  OTPScreen({super.key, required this.argument});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late TextEditingController _otpController;
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    AppHelper.printMessage(widget.argument);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      body: SafeArea(
        child: Consumer<UserLoginProvider>(builder: (context, provider, child) {
          if (provider.networkError != null) {
            if (provider.networkError!) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppHelper.showErrorMessage(
                    context, provider.networkMessage ?? "");
              });
            } else {
              if (widget.argument.containsKey('fromRegistrationAndClubApp')) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.navigateAndClearStack(
                      context, AppNavigator.chooseMembershipScreen,
                      arguments: widget.argument);
                });
              } else {
                /// NAVIGATE TO HOME SCREEN
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.navigateAndClearStack(
                      context, AppNavigator.home);
                });
              }
            }
            provider.resetNetworkResponseStatus();
          }

          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Applogo(),
                    Text(
                      loc.txtEnterVerificationCode,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_5,
                    Text(
                      "${loc.msgEnterVerificationCode}${AppHelper.maskPhoneNumber(widget.argument['phoneNo'].toString())}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_20,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        loc.txtVerificationCode,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    AppDimens.shape_5,
                    TextFormField(
                      maxLines: 1,
                      maxLength: 4,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: _otpController,
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionHandleColor),
                      decoration: InputDecoration(
                        counter: AppDimens.shape_5,
                        fillColor:
                            AppThemeCustom.getTextFieldBackground(context),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        hintText: 'XXXX',
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    AppDimens.shape_20,
                    AppDimens.shape_20,
                    AppButton(
                        text: loc.txtSubmit,
                        onClick: () {
                          if (_otpController.text.isNotEmpty) {
                            AppHelper.printMessage(widget.argument);
                            provider.verifyOTP(
                                userId: widget.argument['userId'].toString(),
                                countryCode:
                                    widget.argument['countryCode'].toString(),
                                otp: _otpController.text);
                          } else {
                            AppHelper.showErrorMessage(
                                context, loc.msgIncorrectOTP);
                          }
                        }),
                  ],
                ),
              ),
              provider.showLoader
                  ? AppLoader(
                      loaderMessage: loc.msgVerifyingOTP,
                    )
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}
