import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../view_models/UserInfoProvider.dart';
import '../../common_widgets/AppCustomButton.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  late TextEditingController _phoneController;
  late UserInfoProvider _userInfoProvider;
late AppLocalizations loc;
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
    loc = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDimens.shape_10,
            Text(
              loc.txtPhoneNumber.toUpperCase(),
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
                  color: AppThemeCustom.getTextFieldTextColor(context)),
              decoration: InputDecoration(
                counterText: "",
                hintText: "0400000000",
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                fillColor: AppThemeCustom.getTextFieldBackground(context),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
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
                    child: AppCustomButton(
                  text: loc.txtCancel.toUpperCase(),
                  onClick: () {
                    provider
                        .updateSelectedEditScreen(UserInfoProvider.EDIT_SCREEN);
                  },
                  style: AppThemeCustom.getUpdateInfoButtonStyle(context),
                )),
                AppDimens.shape_20,
                Expanded(
                    child: AppCustomButton(
                  text: loc.txtUpdate.toUpperCase(),
                  textColor: AppThemeCustom.getUpdateInfoTextColor(context),
                  onClick: () {
                    if (_phoneController.text.isNotEmpty &&
                        AppHelper.verifyPhoneNumber(_phoneController.text)) {
                      provider.updateTempUser(phone: _phoneController.text);
                      provider.updateSelectedEditScreen(
                          UserInfoProvider.EDIT_SCREEN);
                    } else {
                      AppHelper.showErrorMessage(
                          context, loc.msgIncorrectPhoneNumber);
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
