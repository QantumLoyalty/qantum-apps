import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../view_models/UserInfoProvider.dart';

class RecoveryEmailCard extends StatelessWidget {
  bool editable;

  RecoveryEmailCard({super.key, required this.editable});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.txtRecoveryEmail.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context)
                              .colorScheme!
                              .secondary),
                    ),
                  ),
                  editable
                      ? InkWell(
                          onTap: () {
                            provider.updateSelectedEditScreen(
                                UserInfoProvider.EMAIL_EDIT_SCREEN);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 8, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(AppLocalizations.of(context)!.txtEdit.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor)),
                                Icon(
                                  Icons.chevron_right,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  size: 18,
                                )
                              ],
                            ),
                          ))
                      : Container(),
                ],
              ),
              AppDimens.shape_5,
              Text(
                editable
                    ? (provider.tempUser != null
                        ? provider.tempUser!.email ?? ""
                        : "")
                    : AppHelper.maskEmail(provider.getUserInfo!.email),
                style: TextStyle(
                    color: editable
                        ? Theme.of(context).textSelectionTheme.selectionColor
                        : Theme.of(context)
                            .textSelectionTheme
                            .selectionColor
                            ?.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
