import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

class EditMailScreen extends StatefulWidget {
  const EditMailScreen({super.key});

  @override
  State<EditMailScreen> createState() => _EditMailScreenState();
}

class _EditMailScreenState extends State<EditMailScreen> {
  late TextEditingController _emailController;
  late UserInfoProvider _userInfoProvider;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    _emailController = TextEditingController(
        text: _userInfoProvider.tempUser != null
            ? _userInfoProvider.tempUser!.email
            : "");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDimens.shape_10,
            Text(
              AppStrings.txtRecoveryEmail.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
            AppDimens.shape_5,
            TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.msgEmptyEmail;
                } else if (!AppHelper.verifyEmailAddress(value)) {
                  return AppStrings.msgIncorrectEmail;
                }

                return null;
              },
              decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor.withValues(alpha: 0.15),
                filled: true,
                hintText: AppStrings.hintEmail,
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
                          if (_emailController.text.toString().isEmpty) {
                            AppHelper.showErrorMessage(
                                context, AppStrings.msgEmptyEmail);
                          } else if (!AppHelper.verifyEmailAddress(
                              _emailController.text.toString())) {
                            AppHelper.showErrorMessage(
                                context, AppStrings.msgIncorrectEmail);
                          } else {
                            provider.updateTempUser(
                                email: _emailController.text.toString());
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
