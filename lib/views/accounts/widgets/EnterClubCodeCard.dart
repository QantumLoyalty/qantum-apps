import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/spacer_extension.dart';
import 'package:qantum_apps/data/models/SponsorshipModel.dart';

import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../view_models/MyAccountProvider.dart';
import '../../../view_models/UserInfoProvider.dart';
import '../../common_widgets/AppCustomButton.dart';

class EnterClubCodeCard extends StatefulWidget {
  const EnterClubCodeCard({super.key});

  @override
  State<EnterClubCodeCard> createState() => _EnterClubCodeCardState();
}

class _EnterClubCodeCardState extends State<EnterClubCodeCard> {
  late AppLocalizations loc;
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            loc.txtClubCode.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppThemeCustom.getAccountSectionItemStyle(context,
                    isHeadingCommunication: true, isCommunication: true)),
          ),
          15.h,
          Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: AppColors.black.withOpacity(0.2),
                // visible highlight
                cursorColor: AppThemeCustom.getTextFieldTextColor(context),
                selectionHandleColor:
                    AppThemeCustom.getTextFieldTextColor(context),
              ),
            ),
            child: TextFormField(
              controller: _codeController,
              style: TextStyle(
                  fontSize: 16,
                  color: AppThemeCustom.getTextFieldTextColor(context)),
              maxLines: 1,
              maxLength: 80,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.only(left: 15, right: 15),
                hintText: loc.msgEnterClubCode,
                hintStyle:
                    TextStyle(fontSize: 20, color: Theme.of(context).hintColor),
                filled: true,
                fillColor: AppThemeCustom.getTextFieldBackground(context),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          30.h,
          (provider.activeSponsorship != null &&
                  provider.activeUpdateSponsorship)
              ? Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.error_red)),
                          onPressed: () {
                            provider.updateSponsorshipCode(updateStatus: false);
                          },
                          child: Text(
                            loc.txtCancel.toUpperCase(),
                            style: TextStyle(color: AppColors.white),
                          )),
                    ),
                    20.w,
                    Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.success_green)),
                            onPressed: () async {
                              SponsorshipModel? sponsorship = await provider
                                  .checkClubCode(_codeController.text);
                              if (sponsorship != null) {
                                var response = await showConfirmClubCodeDialog(
                                    sponsorship);

                                if (response != null && response) {
                                  String userId = context
                                          .read<UserInfoProvider>()
                                          .getUserInfo!
                                          .bluizeUniqueUserId ??
                                      "";

                                  provider.addSponsorshipCode(
                                      code: _codeController.text,
                                      userId: userId,
                                      loc: loc);
                                }
                              } else {
                                AppHelper.showErrorMessage(
                                    context, "No code found!");
                              }
                            },
                            child: Text(
                              loc.txtUpdate.toUpperCase(),
                              style: TextStyle(color: AppColors.white),
                            ))),
                  ],
                )
              : AppCustomButton(
                  style: AppHelper.getAccountsButtonStyle(context),
                  textColor: AppHelper.getAccountsButtonTextColor(context),
                  text: loc.txtAdd.toUpperCase(),
                  onClick: () async {
                    if (_codeController.text.isNotEmpty) {
                      SponsorshipModel? sponsorship =
                          await provider.checkClubCode(_codeController.text);
                      if (sponsorship != null) {
                        var response =
                            await showConfirmClubCodeDialog(sponsorship);
                        if (response != null && response) {
                          String userId = context
                                  .read<UserInfoProvider>()
                                  .getUserInfo!
                                  .bluizeUniqueUserId ??
                              "";

                          provider.addSponsorshipCode(
                              code: _codeController.text,
                              userId: userId,
                              loc: loc);
                        }
                      } else {
                        AppHelper.showErrorMessage(context, "No code found!");
                      }

                      /*
                    String userId = context
                            .read<UserInfoProvider>()
                            .getUserInfo!
                            .bluizeUniqueUserId ??
                        "";

                    context.read<MyAccountProvider>().updateSponsorshipCode(
                        code: _codeController.text, userId: userId, loc: loc);*/
                    } else {
                      AppHelper.showErrorMessage(context, loc.msgEnterClubCode);
                    }
                  })
        ],
      );
    });
  }

  Future<bool?> showConfirmClubCodeDialog(SponsorshipModel sponsorship) async {
    bool response = false;
    response = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    12.h,
                    Text(
                      loc.verifyClubCode,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    8.h,
                    Text(
                      loc.msgVerifyClubCode
                          .replaceAll("###", sponsorship.company ?? ""),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    10.h,
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    10.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text(
                              loc.txtNo.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              loc.yesConfirm.toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ));
        });

    return response;
  }
}
