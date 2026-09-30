import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/data/models/SponsorshipModel.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';

import '../../../core/extensions/spacer_extension.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../l10n/app_localizations.dart';
import '../../common_widgets/AppCustomButton.dart';

class AddedClubCodeCard extends StatefulWidget {
  late SponsorshipModel activeSponsorship;

  AddedClubCodeCard({super.key, required this.activeSponsorship});

  @override
  State<AddedClubCodeCard> createState() => _AddedClubCodeCardState();
}

class _AddedClubCodeCardState extends State<AddedClubCodeCard> {
  late AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
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
        Text(
          "${widget.activeSponsorship.company}(${widget.activeSponsorship.sponsorshipCode})",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppThemeCustom.getAccountSectionItemStyle(context)),
        ),
        30.h,
        Row(
          children: [
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.error_red)),
                  child: Text(
                    loc.txtRemove.toUpperCase(),
                    style: TextStyle(color: AppColors.white),
                  ),
                  onPressed: () async {
                    var response = await showRemoveClubCodeDialog();

                    if (response != null && response) {
                      final result = await context
                          .read<UserInfoProvider>()
                          .removeActiveSponsorshipCode();

                      if (!context.mounted) return;

                      if (result.success) {
                        AppHelper.showSuccessMessage(context,
                            result.errorMesg ?? "Code removed successfully!");
                      } else {
                        AppHelper.showErrorMessage(
                            context, result.errorMesg ?? "");
                      }
                    }
                  }),
            ),
            20.w,
            Expanded(
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.success_green)),
                    child: Text(
                      loc.txtUpdate.toUpperCase(),
                      style: TextStyle(color: AppColors.white),
                    ),
                    onPressed: () {
                      context
                          .read<UserInfoProvider>()
                          .updateSponsorshipCode(updateStatus: true);
                    })),
          ],
        )
      ],
    );
  }

  Future<bool?> showRemoveClubCodeDialog() async {
    var response = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    12.h,
                    Text(
                      loc.txtAlert,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    8.h,
                    Text(
                      loc.msgRemoveLink.replaceAll(
                          "###", widget.activeSponsorship.company ?? ""),
                      textAlign: TextAlign.center,
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
                              loc.txtYes.toUpperCase(),
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
