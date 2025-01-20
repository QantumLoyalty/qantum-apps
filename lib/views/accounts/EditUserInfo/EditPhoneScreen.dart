import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  late TextEditingController _phoneController;
  late UserInfoProvider _userInfoProvider;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    _phoneController = TextEditingController(
        text: _userInfoProvider.tempUser != null
            ? _userInfoProvider.tempUser!.mobile
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
              AppStrings.txtPhoneNumber.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
            AppDimens.shape_5,
            TextFormField(
              maxLines: 1,
              maxLength: 10,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: _phoneController,
              style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor),
              decoration: InputDecoration(
                counterText: "",
                hintText: "0400000000",
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                fillColor: Theme.of(context).cardColor.withValues(alpha: 0.15),
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                          if (_phoneController.text.isNotEmpty &&
                              AppHelper.verifyPhoneNumber(
                                  _phoneController.text)) {
                            provider.updateTempUser(
                                phone: _phoneController.text);
                            provider.updateSelectedEditScreen(
                                UserInfoProvider.EDIT_SCREEN);
                          } else {
                            AppHelper.showErrorMessage(
                                context, AppStrings.msgIncorrectPhoneNumber);
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
