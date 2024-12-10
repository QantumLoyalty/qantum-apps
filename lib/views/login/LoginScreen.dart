import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';
import 'package:qantum_apps/view_models/UserLoginProvider.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';

import '../../core/navigation/AppNavigator.dart';
import '../common_widgets/AppButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserLoginProvider>(builder: (context, provider, child) {
          // CHECKING USER STATUS & NAVIGATING AS PER THE STATUS
          if (provider.isExistingUser != null) {
            Future.delayed(Duration.zero, () {
              if (provider.isExistingUser!) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.navigateTo(context, AppNavigator.otp);
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.navigateReplacement(context, AppNavigator.signup,
                      arguments: _phoneController.text.toString());
                });
              }

              provider.resetUserStatus();
            });
          }

          // DISPLAYING NETWORK RESPONSE
          if (provider.networkError != null && provider.networkError != null) {
            Future.delayed(Duration.zero, () {
              if (provider.networkError!) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppHelper.showErrorMessage(
                      context, provider.networkMessage ?? "");
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppHelper.showSuccessMessage(
                      context, provider.networkMessage ?? "");
                });
              }

              provider.resetNetworkResponseStatus();
            });
          }

          return Container(
            padding: const EdgeInsets.all(AppDimens.screenPadding),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppDimens.shape_20,
                    Text(
                      AppStrings.txtWelcome,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_10,
                    Text(
                      AppStrings.txtEnterYourNumber,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    AppDimens.shape_20,
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        maxLines: 1,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _phoneController,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                          // fillColor: Theme.of(context).cardColor,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    AppDimens.getCustomBoxShape(30),
                    AppButton(
                      text: AppStrings.txtOk,
                      onClick: () {
                        if (_phoneController.text.isNotEmpty &&
                            AppHelper.verifyPhoneNumber(
                                _phoneController.text)) {
                          provider.login("+91${_phoneController.text}");
                        } else {
                          AppHelper.showErrorMessage(
                              context, AppStrings.msgIncorrectPhoneNumber);
                        }
                      },
                    ),
                  ],
                ),
                provider.showLoader ? AppLoader() : Container()
              ],
            ),
          );
        }),
      ),
    );
  }
}
