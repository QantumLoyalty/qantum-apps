import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/navigation/AppNavigator.dart';
import '../../../l10n/app_localizations.dart';
import '../../common_widgets/AppScaffold.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../view_models/UserInfoProvider.dart';
import '../../common_widgets/AppButton.dart';
import '../../common_widgets/AppLoader.dart';
import '../../common_widgets/AppLogo.dart';

class RecoverAccountVerificationScreen extends StatefulWidget {
  Map<String, dynamic> params;

  RecoverAccountVerificationScreen({super.key, required this.params});

  @override
  State<RecoverAccountVerificationScreen> createState() =>
      _RecoverAccountVerificationScreenState();
}

class _RecoverAccountVerificationScreenState
    extends State<RecoverAccountVerificationScreen> {
  late TextEditingController _otpController;
  int remainingSec = 120;
  bool enableResend = false;
  Timer? timer;
  late UserInfoProvider _userInfoProvider;
  late bool verifyOTPEmail;
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();

    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    //_userInfoProvider.sendOTPAccount();
    verifyOTPEmail = widget.params["verifyOTPEmail"];
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
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      body: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        if (context.mounted) {
          /// CHECKING FOR OTP SEND CASE
          if (provider.emailOTPSent != null) {
            if (provider.emailOTPSent!) {
              Future.delayed(Duration.zero, () {
                AppHelper.showSuccessMessage(
                    context, provider.networkMessage ?? loc.msgOtpSent);
                provider.resetNetworkResponse();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(
                    context, provider.networkMessage ?? loc.msgOtpIssue);
                provider.resetNetworkResponse();
              });
            }
          }

          /// CHECKING FOR OTP SEND CASE ON NEW MOBILE NUMBER
          if (provider.newMobileOTPSent != null) {
            if (provider.newMobileOTPSent!) {
              Future.delayed(Duration.zero, () {
                AppHelper.showSuccessMessage(
                    context, provider.networkMessage ?? loc.msgOtpSent);
                provider.resetNetworkResponse();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(
                    context, provider.networkMessage ?? loc.msgOtpIssue);
                provider.resetNetworkResponse();
              });
            }
          }

          /// CHECKING FOR OTP VERIFY CASE
          if (provider.accountVerified != null) {
            if (provider.accountVerified!) {
              Future.delayed(Duration.zero, () {
                if (verifyOTPEmail) {
                  AppNavigator.navigateAndClearStack(
                      context, AppNavigator.recoverAccountNewPhone,
                      arguments: widget.params);
                } else {
                  AppNavigator.navigateAndClearStack(
                      context, AppNavigator.recoverAccountSuccess);
                }

                provider.resetNetworkResponse();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(context,
                    provider.networkMessage ?? loc.msgIssueInVerifyAccount);
                provider.resetNetworkResponse();
              });
            }
          }
        }
        return SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.chevron_left,
                            size: 28,
                            //  color: AppThemeCustom.getAccountHeaderColor(context),
                          )),
                    ),
                    Applogo(
                      hideTopLine: true,
                    ),
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
                      //"${AppStrings.msgEnterVerificationCode}${provider.getUserInfo != null ? AppHelper.maskPhoneNumber(provider.getUserInfo!.mobile ?? "") : ""}",
                      verifyOTPEmail
                          ? "${loc.msgVerificationCodeSentToEmail} ${AppHelper.maskEmailSecond(widget.params["email"])}"
                          : "${loc.msgVerificationCodeSentToPhone} ${AppHelper.maskPhoneNumber(widget.params["newPhone"])}",
                      textAlign: TextAlign.center,
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
                          color: AppThemeCustom.getTextFieldTextColor(context)),
                      decoration: InputDecoration(
                        counter: AppDimens.shape_5,
                        fillColor:
                            AppThemeCustom.getTextFieldBackground(context),
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
                    AppDimens.shape_15,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1))),
                          onPressed: () {
                            _resetResendCode();
                          },
                          child: Text(
                            "${loc.txtResendCode}${remainingSec != 0 ? " (${remainingSec}s)" : ""}",
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
                    AppDimens.shape_15,
                    AppButton(
                        text: loc.txtSubmit.toUpperCase(),
                        onClick: () {
                          if (_otpController.text.isNotEmpty) {
                            if (verifyOTPEmail) {
                              provider.verifyEmailOTPAccount(
                                  phone: widget.params['phone'],
                                  OTP: _otpController.text,
                                  loc: loc);
                            } else {
                              provider.verifyNewPhoneOTP(
                                  OTP: _otpController.text,
                                  params: widget.params,
                                  loc: loc);
                            }
                          } else {
                            AppHelper.showErrorMessage(
                                context, loc.msgIncorrectOTP);
                          }
                        }),
                  ],
                ),
              ),
              provider.showLoader != null && provider.showLoader!
                  ? AppLoader(
                      loaderMessage:
                          provider.loaderMessage ?? loc.msgPleaseWait,
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
      if (verifyOTPEmail) {
        _userInfoProvider.reSendOTPEmail(widget.params['phone'], loc: loc);
      } else {
        _userInfoProvider.reSendOTPNewPhone(widget.params['newPhone'],
            loc: loc);
      }
      setState(() {
        remainingSec = 120;
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
