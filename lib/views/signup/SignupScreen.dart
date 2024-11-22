import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';
import 'package:qantum_apps/view_models/SignupProvider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<SignupProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.msgItLooksLikeNewUser,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).textSelectionTheme.selectionColor),
                ),
                Text(
                  AppStrings.msgFillDetailsForSignup,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textSelectionTheme.selectionColor),
                ),
                AppDimens.shape_20,
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      hintText: AppStrings.txtFirstName,
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400)),
                ),
                AppDimens.shape_10,
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      hintText: AppStrings.txtLastName,
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400)),
                ),
                AppDimens.shape_10,
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      hintText: AppStrings.hintEmail,
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.txtPostcode,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                color: Theme.of(context).cardColor,
                                child: TextFormField(
                                  maxLines: 1,
                                  maxLength: 4,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context).cardColor,
                                      filled: true,
                                      counterText: "",
                                      hintText: "5555",
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      AppDimens.shape_20,
                      Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.txtBirthday,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 12),
                              ),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    color: Theme.of(context).cardColor,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              maxLines: 1,
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                  counterText: "",
                                                  hintText: "DD",
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none),
                                            )),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          width: 1,
                                          height: 20,
                                          color: AppColors.sr_button_color,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              maxLines: 1,
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                  counterText: "",
                                                  hintText: "MM",
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none),
                                            )),
                                        Container(
                                          width: 1,
                                          height: 20,
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          color: AppColors.sr_button_color,
                                        ),
                                        Expanded(
                                            flex: 6,
                                            child: TextFormField(
                                              maxLines: 1,
                                              maxLength: 4,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                  counterText: "",
                                                  hintText: "YYYY",
                                                  hintStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none),
                                            )),
                                      ],
                                    )),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                AppDimens.shape_10,
                Row(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                            value: SignupProvider.male,
                            groupValue: provider.selectedGender,
                            onChanged: (value) {
                              provider.updateGender(value!);
                            }),
                        Text(
                          SignupProvider.male,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 12),
                        )
                      ],
                    ),
                    AppDimens.shape_20,
                    Row(
                      children: [
                        Radio<String>(
                            value: SignupProvider.female,
                            groupValue: provider.selectedGender,
                            onChanged: (value) {
                              provider.updateGender(value!);
                            }),
                        Text(
                          SignupProvider.female,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                AppDimens.shape_20,
              
                //CheckboxListTile(value: true, onChanged: (value){}),
              
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: provider.tcCheckStatus,
                    title: Text(
                      AppStrings.msgTermsAndConditionSignup,
                      style: TextStyle(
                          color:
                              Theme.of(context).textSelectionTheme.selectionColor,
                          fontSize: 12),
                    ),
                    onChanged: (value) {
                      provider.updateTCCheckStatus(value!);
                    }),
                AppDimens.shape_20,
                TextButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).buttonTheme.colorScheme?.primary)),
                    onPressed: () {
                      AppNavigator.navigateTo(context, AppNavigator.otp);
                    },
                    child: Text(
                      AppStrings.txtJoinNow,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                        ),
                    ))
              ],
            ),
          ),
        ),
      );
    }));
  }
}
