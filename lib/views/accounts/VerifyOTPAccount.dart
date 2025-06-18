import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../view_models/UserInfoProvider.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
import '../common_widgets/AppCustomButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';

class VerifyOTPAccount extends StatefulWidget {
  VerifyOTPAccount();

  @override
  State<VerifyOTPAccount> createState() => _VerifyOTPAccountState();
}

class _VerifyOTPAccountState extends State<VerifyOTPAccount> {
  late TextEditingController _otpController;

  int remainingSec = 30;
  bool enableResend = false;
  Timer? timer;
  late UserInfoProvider _userInfoProvider;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    _userInfoProvider.sendOTPAccount();

    _otpController = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSec != 0) {
        setState(() {
          remainingSec--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeCustom.getCustomScaffoldBackground(context),
      body: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        if (context.mounted) {
          /// CHECKING FOR OTP SEND CASE
          if (provider.otpSent != null) {
            if (provider.otpSent!) {
              Future.delayed(Duration.zero, () {
                AppHelper.showSuccessMessage(context,
                    provider.networkMessage ?? "OTP sent successfully!!!");
                provider.resetNetworkResponse();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(
                    context,
                    provider.networkMessage ??
                        "Issue while sending the OTP!!!");
                provider.resetNetworkResponse();
              });
            }
          }

          /// CHECKING FOR OTP VERIFY CASE
          if (provider.accountVerified != null) {
            if (provider.accountVerified!) {
              Future.delayed(Duration.zero, () {
                AppNavigator.navigateReplacement(
                    context, AppNavigator.editUserDetailsScreen);
                provider.resetNetworkResponse();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(
                    context,
                    provider.networkMessage ??
                        "Issue in verification of your account, please try again.");
                provider.resetNetworkResponse();
              });
            }
          }
        }
        return SafeArea(
          child: Stack(
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
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Applogo(
                      hideTopLine: true,
                    ),
                    Text(
                      AppStrings.txtEnterVerificationCode,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_5,
                    Text(
                      "${AppStrings.msgEnterVerificationCode}${provider.getUserInfo != null ? AppHelper.maskPhoneNumber(provider.getUserInfo!.mobile ?? "") : ""}",
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
                        AppStrings.txtVerificationCode,
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
                              .selectionColor),
                      decoration: InputDecoration(
                        counter: AppDimens.shape_5,
                        fillColor:
                            Theme.of(context).cardColor.withValues(alpha: 0.15),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        hintText: 'XXXX',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
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
                      ),
                    ),
                    AppDimens.shape_5,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            _resetResendCode();
                          },
                          child: Text(
                            "Resend code${remainingSec != 0 ? " (${remainingSec}s)" : ""}",
                            style: TextStyle(
                              color: remainingSec == 0
                                  ? Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor
                                  : Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!
                                      .withValues(alpha: 0.5),
                            ),
                          )),
                    ),
                    AppDimens.shape_5,
                    AppCustomButton(
                      text: AppStrings.txtSubmit.toUpperCase(),
                      textColor: AppHelper.getAccountsButtonTextColor(context),
                      onClick: () {
                        if (_otpController.text.isNotEmpty) {
                          provider.verifyOTPAccount(OTP: _otpController.text);
                        } else {
                          AppHelper.showErrorMessage(
                              context, AppStrings.msgIncorrectOTP);
                        }
                      },
                      style: AppHelper.getAccountsButtonStyle(context),
                    ),
                  ],
                ),
              ),
              provider.showLoader != null && provider.showLoader!
                  ? AppLoader(
                      loaderMessage: provider.loaderMessage ?? "Please wait..",
                    )
                  : Container()
            ],
          ),
        );
      }),
    );
  }

  void _resetResendCode() {
    if (remainingSec == 0) {
      _userInfoProvider.resendOTPAccount();

      setState(() {
        remainingSec = 30;
        enableResend = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
