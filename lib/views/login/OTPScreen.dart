import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
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

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    AppHelper.printMessage(widget.argument);
  }

  @override
  Widget build(BuildContext context) {
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
              /// NAVIGATE TO HOME SCREEN
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppNavigator.navigateAndClearStack(context, AppNavigator.home);
              });
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
                      "${AppStrings.msgEnterVerificationCode}${AppHelper.maskPhoneNumber(widget.argument['phoneNo'].toString())}",
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
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        hintText: 'XXXX',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    AppDimens.shape_20,
                    AppDimens.shape_20,
                    AppButton(
                        text: AppStrings.txtSubmit,
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
                                context, AppStrings.msgIncorrectOTP);
                          }
                        }),
                  ],
                ),
              ),
              provider.showLoader
                  ? AppLoader(
                      loaderMessage: AppStrings.msgVerifyingOTP,
                    )
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}
