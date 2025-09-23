import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/mixins/dob_mixin.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../view_models/UserInfoProvider.dart';
import '../../common_widgets/AppCustomButton.dart';

class EditDetailScreen extends StatefulWidget {
  const EditDetailScreen({super.key});

  @override
  State<EditDetailScreen> createState() => _EditDetailScreenState();
}

class _EditDetailScreenState extends State<EditDetailScreen> with DOBMixin {
  late TextEditingController _fullNameFieldController;
  late TextEditingController _birthdayDDController;
  late TextEditingController _birthdayMMController;
  late TextEditingController _birthdayYYController;
  late FocusNode _birthdayDDFocusNode;
  late FocusNode _birthdayMMFocusNode;
  late FocusNode _birthdayYYFocusNode;

  late UserInfoProvider _userInfoProvider;
late AppLocalizations loc;
  @override
  void initState() {
    super.initState();

    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    _fullNameFieldController = TextEditingController(
        text:
            "${_userInfoProvider.tempUser!.firstName ?? ""} ${_userInfoProvider.tempUser!.lastName ?? ""}");

    DateTime? dateTime;
    try {
      dateTime = DateFormat("yyyy-MM-ddThh:mm:ss.000Z")
          .parse(_userInfoProvider.tempUser!.dateOfBirth ?? "");
    } catch (e) {
      AppHelper.printMessage("Exception in parsing birthdate $e");
    }

    _birthdayDDController = TextEditingController(
        text: ConditionBuilder
            .on(() => dateTime != null && dateTime.day > 10,
                () => dateTime!.day.toString())
            .on(() => dateTime != null && dateTime.day < 10,
                () => "0${dateTime!.day.toString()}")
            .build(orElse: () => ""));
    _birthdayMMController = TextEditingController(
        text: ConditionBuilder.on(() => dateTime != null && dateTime.month > 10,
                () => dateTime!.month.toString())
            .on(() => dateTime != null && dateTime.month < 10,
                () => "0${dateTime!.month.toString()}")
            .build(orElse: () => ""));
    _birthdayYYController = TextEditingController(
        text: dateTime != null ? dateTime.year.toString() : "");

    _birthdayDDFocusNode = FocusNode();
    _birthdayMMFocusNode = FocusNode();
    _birthdayYYFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.txtFullName.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
            AppDimens.shape_5,
            TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              controller: _fullNameFieldController,
              validator: (value) {
                if (value!.isEmpty) {
                  return loc.msgEmptyFirstName;
                }
                return null;
              },
              style: TextStyle(
                  color: AppThemeCustom.getTextFieldTextColor(context)),
              decoration: InputDecoration(
                fillColor: AppThemeCustom.getTextFieldBackground(context),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            AppDimens.shape_20,
            Text(
              loc.txtBirthday.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
            AppDimens.shape_5,
            Container(
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                    color: AppThemeCustom.getTextFieldBackground(context),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          maxLines: 1,
                          maxLength: 2,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _birthdayDDController,
                          focusNode: _birthdayDDFocusNode,
                          style: TextStyle(
                              color: AppThemeCustom.getTextFieldTextColor(
                                  context)),
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "DD",
                              hintStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none),
                          onChanged: (value) {
                            if (value.length == 2) {
                              int? day = int.tryParse(value);
                              if (day != null && day > 31) {
                                _birthdayDDController.text = '31';
                                _birthdayDDController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset:
                                          _birthdayDDController.text.length),
                                );
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(_birthdayMMFocusNode);
                              }
                            }
                          }),
                    ),
                    Expanded(
                        child: TextFormField(
                      maxLines: 1,
                      maxLength: 2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: _birthdayMMController,
                      focusNode: _birthdayMMFocusNode,
                      style: TextStyle(
                          color: AppThemeCustom.getTextFieldTextColor(context)),
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "MM",
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 2) {
                          int? day = int.tryParse(value);
                          if (day != null && day > 12) {
                            _birthdayMMController.text = '12';
                            _birthdayMMController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: _birthdayMMController.text.length),
                            );
                          } else {
                            FocusScope.of(context)
                                .requestFocus(_birthdayYYFocusNode);
                          }
                        }
                      },
                    )),
                    Expanded(
                        child: TextFormField(
                            maxLines: 1,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _birthdayYYController,
                            focusNode: _birthdayYYFocusNode,
                            style: TextStyle(
                                color: AppThemeCustom.getTextFieldTextColor(
                                    context)),
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "YYYY",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none),
                            onChanged: (value) {
                              if (value.length == 4) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            })),
                  ],
                )),
            AppDimens.shape_30,
            Row(
              children: [
                Expanded(
                    child: AppCustomButton(
                  text: loc.txtCancel.toUpperCase(),
                  onClick: () {
                    if (_fullNameFieldController.text.toString().isEmpty) {
                      AppHelper.showErrorMessage(
                          context, loc.msgIncorrectFullName);
                    } else if (!verifyDOB(
                        date: _birthdayDDController.text.toString(),
                        month: _birthdayMMController.text.toString(),
                        year: _birthdayYYController.text.toString())) {
                      AppHelper.showErrorMessage(
                          context, loc.msgIncorrectDOB);
                    } else {
                      DateTime date = DateTime(
                          int.parse(_birthdayYYController.text.toString()),
                          int.parse(_birthdayMMController.text.toString()),
                          int.parse(_birthdayDDController.text.toString()));
                      DateFormat dateTimeFormat =
                          DateFormat("yyyy-MM-ddThh:mm:ss.000Z");

                      provider.updateTempUser(
                          name: _fullNameFieldController.text.toString(),
                          dob: dateTimeFormat.format(date));

                      provider.updateSelectedEditScreen(
                          UserInfoProvider.EDIT_SCREEN);
                    }
                  },
                  style: AppThemeCustom.getCancelInfoButtonStyle(context),
                )),
                AppDimens.shape_20,
                Expanded(
                    child: AppCustomButton(
                  text: loc.txtUpdate.toUpperCase(),
                  textColor: AppThemeCustom.getUpdateInfoTextColor(context),
                  onClick: () {
                    if (_fullNameFieldController.text.toString().isEmpty) {
                      AppHelper.showErrorMessage(
                          context, loc.msgIncorrectFullName);
                    } else if (!verifyDOB(
                        date: _birthdayDDController.text.toString(),
                        month: _birthdayMMController.text.toString(),
                        year: _birthdayYYController.text.toString())) {
                      AppHelper.showErrorMessage(
                          context, loc.msgIncorrectDOB);
                    } else {
                      DateTime date = DateTime(
                          int.parse(_birthdayYYController.text.toString()),
                          int.parse(_birthdayMMController.text.toString()),
                          int.parse(_birthdayDDController.text.toString()));
                      DateFormat dateTimeFormat =
                          DateFormat("yyyy-MM-ddThh:mm:ss.000Z");

                      provider.updateTempUser(
                          name: _fullNameFieldController.text.toString(),
                          dob: dateTimeFormat.format(date));

                      provider.updateSelectedEditScreen(
                          UserInfoProvider.EDIT_SCREEN);
                    }
                  },
                  style: AppThemeCustom.getUpdateInfoButtonStyle(context),
                )),
              ],
            )
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    _birthdayDDController.dispose();
    _birthdayMMController.dispose();
    _birthdayYYController.dispose();
    _birthdayDDFocusNode.dispose();
    _birthdayMMFocusNode.dispose();
    _birthdayYYFocusNode.dispose();
    super.dispose();

  }
}
