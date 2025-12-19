import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/network/APIList.dart';
import 'package:qantum_apps/views/signup/DrivingLicenseScanScreen.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../view_models/DocumentScanProvider.dart';
import '/core/mixins/logging_mixin.dart';

import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/UpperCaseTextFormatter.dart';
import '../../l10n/app_localizations.dart';
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

class _SignupScreenState extends State<SignupScreen> with LoggingMixin {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _postcodeController;
  late TextEditingController _birthdayDDController;
  late TextEditingController _birthdayMMController;
  late TextEditingController _birthdayYYController;
  late TextEditingController _addressController;
  late TextEditingController _address1Controller;
  late FocusNode _birthdayDDFocusNode;
  late FocusNode _birthdayMMFocusNode;
  late FocusNode _birthdayYYFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late AppLocalizations loc;
  late Flavor flavor;

  @override
  void initState() {
    super.initState();

    logEvent("PARAMS ON SIGNUP: ${widget.argument}");
    flavor = FlavorConfig.instance.flavor!;
    String firstName = "", lastName = "";
    if (widget.argument.containsKey('name')) {
      Map<String, String> namePart =
          AppHelper.extractNameParts(widget.argument['name']!);
      logEvent("Pre-filled name: ${widget.argument['name']}");
      firstName = namePart['firstName'] ?? "";
      lastName = namePart['lastName'] ?? "";
    }

    _firstNameController = TextEditingController(text: firstName);

    _lastNameController = TextEditingController(text: lastName);
    _emailController = TextEditingController();

    _birthdayDDFocusNode = FocusNode();
    _birthdayMMFocusNode = FocusNode();
    _birthdayYYFocusNode = FocusNode();

    String address = "";
    String postcode = "";

    if (widget.argument.containsKey("address")) {
      postcode = AppHelper.getPostcode(widget.argument["address"]!);
      if (postcode.isNotEmpty) {
        address = widget.argument["address"]!.replaceAll(postcode, "");
      } else {
        address = widget.argument["address"]!;
      }
    }

    _postcodeController = TextEditingController(text: postcode);
    _addressController = TextEditingController(text: address);
    _address1Controller = TextEditingController();

    if (widget.argument.containsKey("dob")) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      DateTime? dateTime;
      try {
        dateTime = format.parse(widget.argument["dob"]!);
      } catch (e) {
        logEvent("DOB Parse Error: $e");
      }
      _birthdayDDController = TextEditingController(
          text: ConditionBuilder.on(() => dateTime != null && dateTime.day > 10,
                  () => dateTime!.day.toString())
              .on(() => dateTime != null && dateTime.day < 10,
                  () => "0${dateTime!.day.toString()}")
              .build(orElse: () => ""));
      _birthdayMMController = TextEditingController(
          text: ConditionBuilder.on(
                  () => dateTime != null && dateTime.month > 10,
                  () => dateTime!.month.toString())
              .on(() => dateTime != null && dateTime.month < 10,
                  () => "0${dateTime!.month.toString()}")
              .build(orElse: () => ""));
      _birthdayYYController = TextEditingController(
          text: dateTime != null ? dateTime.year.toString() : "");
    } else {
      _birthdayDDController = TextEditingController();
      _birthdayMMController = TextEditingController();
      _birthdayYYController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _postcodeController.dispose();
    _birthdayDDController.dispose();
    _birthdayMMController.dispose();
    _birthdayYYController.dispose();
    _birthdayDDFocusNode.dispose();
    _birthdayMMFocusNode.dispose();
    _birthdayYYFocusNode.dispose();
    _addressController.dispose();
    _address1Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return AppScaffold(body: Consumer2<SignupProvider, UserLoginProvider>(
        builder: (context, provider, userLoginProvider, child) {
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

      // CHECKING USER STATUS & NAVIGATING AS PER THE STATUS
      if (userLoginProvider.isRegistered != null) {
        Future.delayed(Duration.zero, () {
          if (userLoginProvider.isRegistered!) {
            Map<String, String> args = {};
            args['phoneNo'] = widget.argument['phoneNo']!;
            args['countryCode'] = widget.argument['countryCode']!;
            args['userId'] = "${userLoginProvider.userId}";

            if (AppHelper.isClubApp()) {
              args['fromRegistrationAndClubApp'] = 'true';
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppNavigator.navigateAndClearStack(context, AppNavigator.otp,
                  arguments: args);
            });
          } else {}

          userLoginProvider.resetUserRegisterStatus();
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
                      Applogo(),
                      Text(
                        loc.msgPleaseRegister,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                      AppDimens.shape_5,
                      Text(
                        loc.msgFillDetailsForSignup,
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
                        inputFormatters: <TextInputFormatter>[
                          UpperCaseTextFormatter(),
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[A-Za-z\s'\-]")),
                        ],
                        validator: (value) {
                          /*if (value!.isEmpty) {
                            return loc.msgEmptyFirstName;
                          }
                          return null;*/
                          if (value == null || value.isEmpty) {
                            return loc.msgEmptyFirstName;
                          }
                          final validName = RegExp(r"^[A-Za-z\s'\-]+$");
                          if (!validName.hasMatch(value)) {
                            return "Please avoid special characters";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color:
                                AppThemeCustom.getTextFieldTextColor(context)),
                        decoration: InputDecoration(
                          fillColor:
                              AppThemeCustom.getTextFieldBackground(context),
                          filled: true,
                          hintText: loc.txtFirstName,
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
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
                      AppDimens.shape_10,
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        validator: (value) {
                          /*if (value!.isEmpty) {
                            return loc.msgEmptyLastName;
                          }
                          return null;*/
                          if (value == null || value.isEmpty) {
                            return loc.msgEmptyLastName;
                          }
                          final validName = RegExp(r"^[A-Za-z\s'\-]+$");
                          if (!validName.hasMatch(value)) {
                            return "Please avoid special characters";
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          UpperCaseTextFormatter(),
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[A-Za-z\s'\-]")),
                        ],
                        style: TextStyle(
                            color:
                                AppThemeCustom.getTextFieldTextColor(context)),
                        decoration: InputDecoration(
                          fillColor:
                              AppThemeCustom.getTextFieldBackground(context),
                          filled: true,
                          hintText: loc.txtLastName,
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
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
                      AppDimens.shape_10,
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        style: TextStyle(
                            color:
                                AppThemeCustom.getTextFieldTextColor(context)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return loc.msgEmptyEmail;
                          } else if (!AppHelper.verifyEmailAddress(value)) {
                            return loc.msgIncorrectEmail;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor:
                              AppThemeCustom.getTextFieldBackground(context),
                          filled: true,
                          hintText: loc.hintEmail,
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
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
                      AppHelper.isClubApp()
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppDimens.shape_10,
                                Text(
                                  loc.txtAddress,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor),
                                ),
                                AppDimens.shape_5,
                                TextFormField(
                                  maxLines: 1,
                                  controller: _addressController,
                                  style: TextStyle(
                                      color:
                                          AppThemeCustom.getTextFieldTextColor(
                                              context)),
                                  decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "${loc.txtAddress} 1",
                                      fillColor:
                                          AppThemeCustom.getTextFieldBackground(
                                              context),
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                AppDimens.shape_10,
                                TextFormField(
                                  maxLines: 1,
                                  controller: _address1Controller,
                                  style: TextStyle(
                                      color:
                                          AppThemeCustom.getTextFieldTextColor(
                                              context)),
                                  decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "${loc.txtAddress} 2",
                                      fillColor:
                                          AppThemeCustom.getTextFieldBackground(
                                              context),
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ],
                            )
                          : Container(),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    loc.txtPostcode,
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
                                        color: AppThemeCustom
                                            .getTextFieldTextColor(context)),
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintText: "5555",
                                        fillColor: AppThemeCustom
                                            .getTextFieldBackground(context),
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ))
                                ],
                              ),
                            ),
                            AppDimens.shape_20,
                            Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      loc.txtBirthday,
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
                                              color: AppThemeCustom
                                                  .getTextFieldBackground(
                                                      context),
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
                                                    focusNode:
                                                        _birthdayDDFocusNode,
                                                    style: TextStyle(
                                                        color: AppThemeCustom
                                                            .getTextFieldTextColor(
                                                                context)),
                                                    onChanged: (value) {
                                                      if (value.length == 2) {
                                                        int? day =
                                                            int.tryParse(value);
                                                        if (day != null &&
                                                            day > 31) {
                                                          _birthdayDDController
                                                              .text = '31';
                                                          _birthdayDDController
                                                                  .selection =
                                                              TextSelection
                                                                  .fromPosition(
                                                            TextPosition(
                                                                offset:
                                                                    _birthdayDDController
                                                                        .text
                                                                        .length),
                                                          );
                                                        } else {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  _birthdayMMFocusNode);
                                                        }
                                                      }
                                                    },
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
                                                        color: AppThemeCustom
                                                            .getTextFieldTextColor(
                                                                context)),
                                                    focusNode:
                                                        _birthdayMMFocusNode,
                                                    onChanged: (value) {
                                                      if (value.length == 2) {
                                                        int? day =
                                                            int.tryParse(value);
                                                        if (day != null &&
                                                            day > 12) {
                                                          _birthdayMMController
                                                              .text = '12';
                                                          _birthdayMMController
                                                                  .selection =
                                                              TextSelection
                                                                  .fromPosition(
                                                            TextPosition(
                                                                offset:
                                                                    _birthdayMMController
                                                                        .text
                                                                        .length),
                                                          );
                                                        } else {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  _birthdayYYFocusNode);
                                                        }
                                                      }
                                                    },
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
                                                    focusNode:
                                                        _birthdayYYFocusNode,
                                                    style: TextStyle(
                                                        color: AppThemeCustom
                                                            .getTextFieldTextColor(
                                                                context)),
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
                                                    onChanged: (value) {
                                                      if (value.length == 4) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      }
                                                    },
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
                                  loc.txtMale,
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
                                loc.txtFemale,
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
                                loc.txtNonBinary,
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
                                loc.msgTermsAndConditionSignup,
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
                          onTap: () {
                            AppNavigator.navigateTo(
                                context, AppNavigator.appWebView,
                                arguments: APIList.TERMS_AND_CONDITIONS);
                          },
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: loc.txtView,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color:
                                        AppThemeCustom.getTNCTextColor(context),
                                  )),
                              TextSpan(
                                  text: " ${loc.txtTermsAndConditions}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppThemeCustom.getTNCTextColor(
                                          context),
                                      fontWeight: FontWeight.bold))
                            ]),
                          )),
                      AppDimens.shape_20,
                      AppButton(
                          text: loc.txtJoinNow.toUpperCase(),
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
                                    if (_postcodeController.text.isNotEmpty) {
                                      params['PostCode'] =
                                          _postcodeController.text;
                                    }

                                    params['Email'] = _emailController.text;

                                    if (provider.selectedGender![0]
                                            .toUpperCase() ==
                                        "M") {
                                      params['Gender'] = "M";
                                    } else if (provider.selectedGender![0]
                                            .toUpperCase() ==
                                        "F") {
                                      params['Gender'] = "F";
                                    } else {
                                      params['Gender'] = "U";
                                    }

                                    /// TEMP CONDITION FOR MHBC APP ONLY ///
                                    if (flavor == Flavor.mhbc) {
                                      params['type'] = "new";
                                    }

                                    /// ADDING PARAMS IF APP IS A CLUB APP ///
                                    if (widget.argument
                                        .containsKey('license_front')) {
                                      params['licence_front'] =
                                          widget.argument['license_front'];
                                    }
                                    if (widget.argument
                                        .containsKey('license_back')) {
                                      params['licence_back'] =
                                          widget.argument['license_back'];
                                    }

                                    if (widget.argument
                                        .containsKey('expiryDate')) {
                                      params['expiryDate'] =
                                          widget.argument['expiryDate'];
                                    }

                                    if (_address1Controller.text.isNotEmpty) {
                                      params['Suburb'] =
                                          _address1Controller.text;
                                    }

                                    /////////////////////////////////////////

                                    String phoneNo =
                                        "${widget.argument['countryCode']}${widget.argument['phoneNo']}";

                                    params['State'] = "NA";

                                    params['Address'] =
                                        _addressController.text.toString();

                                    AppHelper.printMessage(
                                        "PARAMS:: $params -> $phoneNo");
                                    userLoginProvider.signup(phoneNo, params,
                                        loc: loc);
                                  } else {
                                    AppHelper.showErrorMessage(context,
                                        loc.msgCheckTermsAndConditions);
                                  }
                                }
                              } else {
                                AppHelper.showErrorMessage(
                                    context, loc.msgEmptyPostcode);
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
                      loaderMessage: loc.msgPleaseWait,
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
        AppHelper.showErrorMessage(context, loc.msgIncorrectDOB);
      } else {
        AppHelper.showErrorMessage(context, loc.msgSelectGender);
      }

      return false;
    }
  }

  bool verifyDOB() {
    if (_birthdayDDController.text.isNotEmpty &&
        _birthdayMMController.text.isNotEmpty &&
        _birthdayYYController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime dob = DateTime(
          int.parse(_birthdayYYController.text),
          int.parse(_birthdayMMController.text),
          int.parse(_birthdayDDController.text));

      if (dob.isBefore(DateTime.now())) {
        int age = now.year - dob.year;

        // If birthday hasn’t occurred yet this year, subtract 1
        if (now.month < dob.month ||
            (now.month == dob.month && now.day < dob.day)) {
          age--;
        }

        print("AGE RESULT :: $age");

        return age >= 18;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
