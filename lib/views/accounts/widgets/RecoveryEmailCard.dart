import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

class RecoveryEmailCard extends StatelessWidget {
  bool editable;

  RecoveryEmailCard({super.key, required this.editable});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).cardColor.withValues(alpha: 0.15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.txtRecoveryEmail.toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .primary),
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
                                  Text(AppStrings.txtEdit.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 12,
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
        ),
      );
    });
  }
}
