import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
import '../../view_models/SignupProvider.dart';
import '../../view_models/UserLoginProvider.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class SignupScreen extends StatefulWidget {
  Map<String, String> argument;

  SignupScreen({super.key, required this.argument});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _postcodeController;
  late TextEditingController _birthdayDDController;
  late TextEditingController _birthdayMMController;
  late TextEditingController _birthdayYYController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _postcodeController = TextEditingController();
    _birthdayDDController = TextEditingController();
    _birthdayMMController = TextEditingController();
    _birthdayYYController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Consumer2<SignupProvider, UserLoginProvider>(
        builder: (context, provider, userLoginProvider, child) {
      // CHECKING USER STATUS & NAVIGATING AS PER THE STATUS
      if (userLoginProvider.isRegistered != null) {
        Future.delayed(Duration.zero, () {
          if (userLoginProvider.isRegistered!) {
            Map<String, String> args = {};
            args['phoneNo'] = widget.argument['phoneNo']!;
            args['countryCode'] = widget.argument['countryCode']!;
            args['userId'] = "${userLoginProvider.userId}";

            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppNavigator.navigateAndClearStack(context, AppNavigator.otp,
                  arguments: args);
            });
          } else {}

          userLoginProvider.resetUserRegisterStatus();
        });
      }

      // DISPLAYING NETWORK RESPONSE
      if (userLoginProvider.networkError != null &&
          userLoginProvider.networkError!) {
        Future.delayed(Duration.zero, () {
          if (userLoginProvider.networkError!) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppHelper.showErrorMessage(
                  context, userLoginProvider.networkMessage ?? "");
            });
          }

          userLoginProvider.resetNetworkResponseStatus();
        });
      }

      return SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Applogo(),
                      Text(
                        AppStrings.msgPleaseRegister,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                      AppDimens.shape_5,
                      Text(
                        AppStrings.msgFillDetailsForSignup,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                      AppDimens.shape_20,
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.msgEmptyFirstName;
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).cardColor,
                          filled: true,
                          hintText: AppStrings.txtFirstName,
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      AppDimens.shape_10,
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.msgEmptyLastName;
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).cardColor,
                          filled: true,
                          hintText: AppStrings.txtLastName,
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      AppDimens.shape_10,
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.msgEmptyEmail;
                          } else if (!AppHelper.verifyEmailAddress(value)) {
                            return AppStrings.msgIncorrectEmail;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).cardColor,
                          filled: true,
                          hintText: AppStrings.hintEmail,
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
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
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    maxLines: 1,
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _postcodeController,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintText: "5555",
                                        fillColor: Theme.of(context).cardColor,
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ))
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
                                          fontSize: 10),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: TextFormField(
                                                    maxLines: 1,
                                                    maxLength: 2,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    controller:
                                                        _birthdayDDController,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor),
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        hintText: "DD",
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: TextFormField(
                                                    maxLines: 1,
                                                    maxLength: 2,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    controller:
                                                        _birthdayMMController,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor),
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        hintText: "MM",
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none),
                                                  )),
                                              Expanded(
                                                  flex: 6,
                                                  child: TextFormField(
                                                    maxLines: 1,
                                                    maxLength: 4,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    controller:
                                                        _birthdayYYController,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor),
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        hintText: "YYYY",
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none),
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
                          Expanded(
                            child: Row(
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
                          ),
                          Expanded(
                              child: Row(
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
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Radio<String>(
                                  value: SignupProvider.nonbinary,
                                  groupValue: provider.selectedGender,
                                  onChanged: (value) {
                                    provider.updateGender(value!);
                                  }),
                              Text(
                                SignupProvider.nonbinary,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 12),
                              )
                            ],
                          )),
                        ],
                      ),
                      AppDimens.shape_20,
                      InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              provider.tcCheckStatus
                                  ? Icons.task_alt
                                  : Icons.circle_outlined,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            AppDimens.getCustomBoxShape(8),
                            Expanded(
                              child: Text(
                                AppStrings.msgTermsAndConditionSignup,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 11),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          provider.updateTCCheckStatus(!provider.tcCheckStatus);
                        },
                      ),

                      /*CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: provider.tcCheckStatus,
                          title: Text(
                            AppStrings.msgTermsAndConditionSignup,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontSize: 11),
                          ),
                          onChanged: (value) {
                            provider.updateTCCheckStatus(value!);
                          }),*/
                      AppDimens.shape_20,
                      InkWell(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: AppStrings.txtView,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .primary)),
                              TextSpan(
                                  text: " ${AppStrings.txtTermsAndConditions}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .primary,
                                      fontWeight: FontWeight.bold))
                            ]),
                          )),
                      AppDimens.shape_20,
                      AppButton(
                          text: AppStrings.txtJoinNow.toUpperCase(),
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              if (_postcodeController.text.isNotEmpty) {
                                if (validateData(provider)) {
                                  if (provider.tcCheckStatus) {
                                    Map<String, dynamic> params = {};
                                    params['GivenNames'] =
                                        _firstNameController.text;
                                    params['Surname'] =
                                        _lastNameController.text;
                                    params['DateOfBirth'] =
                                        '${_birthdayYYController.text}-${_birthdayMMController.text}-${_birthdayDDController.text}';
                                    params['PostCode'] =
                                        _postcodeController.text;
                                    params['Email'] = _emailController.text;
                                    params['Gender'] = provider
                                        .selectedGender![0]
                                        .toUpperCase();
                                    String phoneNo =
                                        "${widget.argument['countryCode']}${widget.argument['phoneNo']}";
                                    AppHelper.printMessage(
                                        "PARAMS:: $params -> $phoneNo");
                                    userLoginProvider.signup(phoneNo, params);
                                  } else {
                                    AppHelper.showErrorMessage(context,
                                        AppStrings.msgCheckTermsAndConditions);
                                  }
                                }
                              } else {
                                AppHelper.showErrorMessage(
                                    context, AppStrings.msgEmptyPostcode);
                              }
                            }

                            // AppNavigator.navigateTo(context, AppNavigator.otp);
                          }),
                    ],
                  ),
                ),
              ),
              userLoginProvider.showLoader
                  ? AppLoader(
                      loaderMessage: AppStrings.msgPleaseWait,
                    )
                  : Container()
            ],
          ),
        ),
      );
    }));
  }

  bool validateData(SignupProvider provider) {
    if (_formKey.currentState!.validate() &&
        provider.selectedGender != null &&
        provider.selectedGender!.isNotEmpty &&
        (verifyDOB())) {
      return true;
    } else {
      if (!verifyDOB()) {
        AppHelper.showErrorMessage(context, AppStrings.msgIncorrectDOB);
      } else {
        AppHelper.showErrorMessage(context, AppStrings.msgSelectGender);
      }

      return false;
    }
  }

  bool verifyDOB() {
    if (_birthdayDDController.text.isNotEmpty &&
        _birthdayMMController.text.isNotEmpty &&
        _birthdayYYController.text.isNotEmpty) {
      DateTime dateTime = DateTime(
          int.parse(_birthdayYYController.text),
          int.parse(_birthdayMMController.text),
          int.parse(_birthdayDDController.text));

      return dateTime.isBefore(DateTime.now()) &&
          (DateTime.now().difference(dateTime).inDays ~/ 365) > 18;
    } else {
      return false;
    }
  }
}
