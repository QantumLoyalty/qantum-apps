import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/mixins/dob_mixin.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

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
  late UserInfoProvider _userInfoProvider;

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
        text: dateTime != null ? dateTime.day.toString() : "");
    _birthdayMMController = TextEditingController(
        text: dateTime != null ? dateTime.month.toString() : "");
    _birthdayYYController = TextEditingController(
        text: dateTime != null ? dateTime.year.toString() : "");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.txtFullName.toUpperCase(),
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
                  return AppStrings.msgEmptyFirstName;
                }
                return null;
              },
              style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor),
              decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor.withValues(alpha: 0.15),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent),borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent),borderRadius: BorderRadius.circular(10)),
                focusedBorder:
                    OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent),borderRadius: BorderRadius.circular(10)),
                errorBorder:
                    OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent),borderRadius: BorderRadius.circular(10)),
              ),
            ),
            AppDimens.shape_20,
            Text(
              AppStrings.txtBirthday.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
            AppDimens.shape_5,
            Container(
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withValues(alpha: 0.15),
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
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                        decoration: InputDecoration(
                            counterText: "",
                            hintText: "DD",
                            hintStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none),
                      ),
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
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "MM",
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
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
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "YYYY",
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    )),
                  ],
                )),
            AppDimens.shape_30,
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        style: ButtonStyle(
                            side: WidgetStatePropertyAll(BorderSide(
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary)),
                            shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(80))))),
                        onPressed: () {
                          provider.updateSelectedEditScreen(
                              UserInfoProvider.EDIT_SCREEN);
                        },
                        child: Text(AppStrings.txtCancel.toUpperCase()))),
                AppDimens.shape_20,
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary),
                            shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(80))))),
                        onPressed: () {
                          if (_fullNameFieldController.text
                              .toString()
                              .isEmpty) {
                            AppHelper.showErrorMessage(
                                context, AppStrings.msgIncorrectFullName);
                          } else if (!verifyDOB(
                              date: _birthdayDDController.text.toString(),
                              month: _birthdayMMController.text.toString(),
                              year: _birthdayYYController.text.toString())) {
                            AppHelper.showErrorMessage(
                                context, AppStrings.msgIncorrectDOB);
                          } else {
                            DateTime date = DateTime(
                                int.parse(
                                    _birthdayYYController.text.toString()),
                                int.parse(
                                    _birthdayMMController.text.toString()),
                                int.parse(
                                    _birthdayDDController.text.toString()));
                            DateFormat dateTimeFormat =
                                DateFormat("yyyy-MM-ddThh:mm:ss.000Z");

                            provider.updateTempUser(
                                name: _fullNameFieldController.text.toString(),
                                dob: dateTimeFormat.format(date));

                            provider.updateSelectedEditScreen(
                                UserInfoProvider.EDIT_SCREEN);
                          }
                        },
                        child: Text(
                          AppStrings.txtUpdate.toUpperCase(),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ))),
              ],
            )
          ],
        );
      }),
    );
  }
}
