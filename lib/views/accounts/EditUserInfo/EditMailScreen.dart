import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';

import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../view_models/UserInfoProvider.dart';
import '../../common_widgets/AppCustomButton.dart';

class EditMailScreen extends StatefulWidget {
  const EditMailScreen({super.key});

  @override
  State<EditMailScreen> createState() => _EditMailScreenState();
}

class _EditMailScreenState extends State<EditMailScreen> {
  late TextEditingController _emailController;
  late UserInfoProvider _userInfoProvider;
  late AppLocalizations loc;

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
    loc = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDimens.shape_10,
            Text(
              loc.txtRecoveryEmail.toUpperCase(),
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
                  color: AppThemeCustom.getTextFieldTextColor(context)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.msgEmptyEmail;
                } else if (!AppHelper.verifyEmailAddress(value)) {
                  return loc.msgIncorrectEmail;
                }

                return null;
              },
              decoration: InputDecoration(
                fillColor: AppThemeCustom.getTextFieldBackground(context),
                filled: true,
                hintText: loc.hintEmail,
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
            AppDimens.shape_30,
            Row(
              children: [
                Expanded(
                    child: AppCustomButton(
                  text: loc.txtCancel.toUpperCase(),
                  onClick: () {
                    provider
                        .updateSelectedEditScreen(UserInfoProvider.EDIT_SCREEN);
                  },
                  style: AppThemeCustom.getCancelInfoButtonStyle(context),
                )),
                AppDimens.shape_20,
                Expanded(
                    child: AppCustomButton(
                  text: loc.txtUpdate.toUpperCase(),
                  textColor: AppThemeCustom.getUpdateInfoTextColor(context),
                  onClick: () {
                    if (_emailController.text.toString().isEmpty) {
                      AppHelper.showErrorMessage(
                          context, loc.msgEmptyEmail);
                    } else if (!AppHelper.verifyEmailAddress(
                        _emailController.text.toString())) {
                      AppHelper.showErrorMessage(
                          context, loc.msgIncorrectEmail);
                    } else {
                      provider.updateTempUser(
                          email: _emailController.text.toString());
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
}
