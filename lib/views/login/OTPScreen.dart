import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
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

class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  late TextEditingController _otpController;
  late AppLocalizations loc;
  late Flavor flavor;
  late UserLoginProvider _loginProvider;
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _loginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    AppHelper.printMessage(widget.argument);
    flavor = FlavorConfig.instance.flavor!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocusNode);
      SystemChannels.textInput.invokeMethod('TextInput.show');
    });
    listenForCode();
  }

  @override
  void dispose() {
    _otpFocusNode.dispose();
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
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (AppHelper.isClubApp()) {
                    /// TEMP CONDITION FOR MHBC APP ONLY
                    if (flavor == Flavor.mhbc) {
                      if (widget.argument.containsKey('isTestUser')) {
                        Map<String, String> args = {};
                        args['isTestUser'] = "true";
                        AppNavigator.navigateAndClearStack(
                            context, AppNavigator.chooseMembershipScreen,
                            arguments: args);
                      } else {
                        if (await AppHelper.checkIfUserIsNew()) {
                          /// IF USER IS NEW AND NEEDS TO SELECT MEMBERSHIP
                          /// CHECKING IF PURCHASED THE MEMBERSHIP
                          if (await AppHelper
                              .checkIfUserHasPurchasedTheMembership()) {
                            /// ALREADY PURCHASED THE MEMBERSHIP
                            AppNavigator.navigateAndClearStack(
                                context, AppNavigator.home);
                          } else {
                            ///  DID NOT PURCHASED THE MEMBERSHIP
                            AppNavigator.navigateAndClearStack(
                                context, AppNavigator.chooseMembershipScreen);
                          }
                        } else {
                          /// IF USER IS OLD
                          AppNavigator.navigateAndClearStack(
                              context, AppNavigator.home);
                        }
                      }
                    } else {
                      /// FOR OTHER APPS
                      /// CHECKING IF PURCHASED THE MEMBERSHIP
                      if (await AppHelper
                          .checkIfUserHasPurchasedTheMembership()) {
                        /// ALREADY PURCHASED THE MEMBERSHIP
                        AppNavigator.navigateAndClearStack(
                            context, AppNavigator.home);
                      } else {
                        ///  DID NOT PURCHASED THE MEMBERSHIP
                        AppNavigator.navigateAndClearStack(
                            context, AppNavigator.pendingPaymentScreen);
                      }
                    }
                  } else {
                    AppNavigator.navigateAndClearStack(
                        context, AppNavigator.home);
                  }
                });
              }
            }
            provider.resetNetworkResponseStatus();
          }

          return Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            size: 28,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          )),
                    ),
                    Applogo(
                      hideTopLine: true,
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(AppDimens.screenPadding),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              loc.txtEnterVerificationCode,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            AppDimens.shape_5,
                            Text(
                              "${loc.msgEnterVerificationCode}${widget.argument['countryCode'].toString()}${widget.argument['phoneNo'].toString()}",
                            //  "${loc.msgEnterVerificationCode}${AppHelper.maskPhoneNumber(widget.argument['phoneNo'].toString())}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
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
                              focusNode: _otpFocusNode,
                              autofillHints: const [AutofillHints.oneTimeCode],
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                if (value.length == 4) {
                                  verifyOTP(_otpController.text);
                                }
                              },
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: _otpController,
                              style: TextStyle(
                                  color:  AppThemeCustom
                                      .getTextFieldTextColor(
                                      context,isShadow: true)),
                              decoration: InputDecoration(
                                counter: AppDimens.shape_5,
                                fillColor:
                                AppThemeCustom.getTextFieldBackground(context,isShadow: true),
                                filled: true,
                                hintStyle:
                                TextStyle(color:AppThemeCustom.getHintTextFieldColor(context,isShadow: true)),
                                hintText: 'XXXX',
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            AppDimens.shape_20,
                            AppButton(
                                text: loc.txtSubmit,
                                onClick: () {
                                  verifyOTP(_otpController.text);
                                }),
                          ],
                        ),
                      ),
                    ))
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

  verifyOTP(String? code) {
    if (code != null && code.isNotEmpty && code.length == 4) {
      AppHelper.printMessage(widget.argument);
      _loginProvider.verifyOTP(
          userId: widget.argument['userId'].toString(),
          countryCode: widget.argument['countryCode'].toString(),
          otp: _otpController.text);
    } else {
      AppHelper.showErrorMessage(context, loc.msgIncorrectOTP);
    }
  }

  @override
  void codeUpdated() {
    if (code != null && code!.length == 4) {
      _otpController.text = code!;
      verifyOTP(code!);
      FocusScope.of(context).unfocus();
    }
  }
}
