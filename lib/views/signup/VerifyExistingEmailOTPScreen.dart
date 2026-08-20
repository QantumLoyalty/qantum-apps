import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class VerifyExistingEmailOTPScreen extends StatefulWidget {
  Map<String, dynamic> params;

  VerifyExistingEmailOTPScreen({super.key, required this.params});

  @override
  State<VerifyExistingEmailOTPScreen> createState() =>
      _VerifyExistingEmailOTPScreenState();
}

class _VerifyExistingEmailOTPScreenState
    extends State<VerifyExistingEmailOTPScreen> {
  late TextEditingController _otpController;
  int remainingSec = 120;
  bool enableResend = false;
  Timer? timer;
  late UserInfoProvider _userInfoProvider;
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
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

    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      sendOTPOnEmail();
    });*/
  }

  sendOTPOnEmail() {
    _userInfoProvider.sendOTPOnExistingEmail(
        email: widget.params["Email"], loc: loc);
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return AppScaffold(
      body: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        if (context.mounted) {
          /// CHECKING FOR OTP SEND CASE
          if (provider.otpSentStatus != null) {
            if (provider.otpSentStatus!) {
              Future.delayed(Duration.zero, () {
                AppHelper.showSuccessMessage(
                    context, provider.networkMessage ?? loc.msgOtpSent);
                provider.resetOtpSentStatus();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(
                    context, provider.networkMessage ?? loc.msgOtpIssue);
                provider.resetOtpSentStatus();
              });
            }
          }

          /// CHECKING FOR OTP VERIFY CASE
          /*if (provider.otpVerificationStatus != null) {
            if (!provider.otpVerificationStatus!) {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(context,
                    provider.otpVerificationMsg ?? loc.msgIssueInVerifyAccount);
                provider.resetOTPVerificationStatus();
              });
            }
          }*/
        }
        return SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Applogo(
                        hideTopLine: true,
                      ),
                      Text(
                        loc.msgEnterEmailOTP,
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
                        "${loc.msgOTPSentToEmail} ${widget.params["Email"]}",
                        textAlign: TextAlign.center,
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
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 4) {
                            verifyOTP();
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _otpController,
                        style: TextStyle(
                            color:
                                AppThemeCustom.getTextFieldTextColor(context)),
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
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.white.withValues(alpha: 0.1))),
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
                            verifyOTP();
                          }),
                    ],
                  ),
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

  verifyOTP() async {
    if (_otpController.text.isNotEmpty) {
      final result = await context
          .read<UserInfoProvider>()
          .verifyOTPOnExistingEmail(
              userId: widget.params["userId"],
              email: widget.params["Email"],
              mobile: widget.params["phoneNo"],
              countryCode: widget.params["countryCode"],
              otp: _otpController.text,
              loc: loc);

      if (!context.mounted) return;

      if (result.success) {
        Map<String, String> args = {};
        args['countryCode'] = widget.params["countryCode"];
        args['phoneNo'] = widget.params["phoneNo"];
        args['userId'] = widget.params["userId"];
        args['hideBackButton'] = "true";
        AppNavigator.navigateAndClearStack(context, AppNavigator.otp,
            arguments: args);

        context
            .read<UserInfoProvider>()
            .resetOTPVerificationStatus(clearAll: true);
      } else {
        AppHelper.showErrorMessage(
            context, result.errorMesg ?? loc.msgCommonError);
      }
    } else {
      AppHelper.showErrorMessage(context, loc.msgIncorrectOTP);
    }
  }

  void _resetResendCode() {
    if (remainingSec == 0) {
      _userInfoProvider.sendOTPOnExistingEmail(
          email: widget.params["Email"], loc: loc);
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
