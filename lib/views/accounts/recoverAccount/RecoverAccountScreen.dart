import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/navigation/AppNavigator.dart';
import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../view_models/UserInfoProvider.dart';
import '../../common_widgets/AppButton.dart';
import '../../common_widgets/AppLoader.dart';
import '../../common_widgets/AppLogo.dart';
import '../../common_widgets/AppScaffold.dart';

class RecoverAccountScreen extends StatefulWidget {
  const RecoverAccountScreen({super.key});

  @override
  State<RecoverAccountScreen> createState() => _RecoverAccountScreenState();
}

class _RecoverAccountScreenState extends State<RecoverAccountScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String countryCode = "+61";
late AppLocalizations loc;
  @override
  Widget build(BuildContext context) {

    loc=AppLocalizations.of(context)!;

    return AppScaffold(
      // backgroundColor: Theme.of(context).primaryColorDark,
      body: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        if (context.mounted) {
          /// CHECKING FOR OTP SEND CASE
          if (provider.otpSent != null) {
            if (provider.otpSent! && provider.tempUser != null) {
              Future.delayed(Duration.zero, () {
                Map<String, dynamic> params = {};
                params['id'] = provider.tempUser!.id!;
                params['bluizeUniqueUserId'] = provider.tempUser!.bluizeUniqueUserId!;
                params['email'] = provider.tempUser!.email!;
                params['phone'] = provider.tempUser!.mobile!;
                params['verifyOTPEmail'] = true;
                AppNavigator.navigateTo(
                    context, AppNavigator.recoverAccountVerificationScreen,
                    arguments: params);
                provider.resetNetworkResponse();
              });
            } else {
              Future.delayed(Duration.zero, () {
                AppHelper.showErrorMessage(
                    context,
                    provider.networkMessage ??
                        loc.msgOtpIssue);
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
                    Applogo(
                      hideTopLine: true,
                    ),
                    Text(
                      loc.txtRecoverYourAccount,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_5,
                    Text(
                      loc.msgEnterMobileNoToRecoverYourAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_20,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        loc.txtMobileNumber,
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
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5,
                              color: Theme.of(context).dividerColor),
                          color: AppThemeCustom.getTextFieldBackground(context),
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
                                color: AppThemeCustom.getTextFieldTextColor(context)),
                            onChanged: (code) {
                              setState(() {
                                countryCode = code.dialCode!;

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
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionHandleColor),
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "0400000000",
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  enabledBorder: InputBorder.none,
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
                    AppDimens.shape_15,
                    AppButton(
                        text: loc.txtSendVerificationCode.toUpperCase(),
                        onClick: () {
                          if (_phoneController.text.isNotEmpty) {
                            provider.sendOTPEmail(_phoneController.text,loc: loc);
                          } else {
                            AppHelper.showErrorMessage(
                                context, loc.msgIncorrectPhoneNumber);
                          }
                        }),
                  ],
                ),
              ),
              provider.showLoader != null && provider.showLoader!
                  ? AppLoader(
                      loaderMessage: provider.loaderMessage ?? loc.msgPleaseWait,
                    )
                  : Container()
            ],
          ),
        );
      }),
    );
  }
}
