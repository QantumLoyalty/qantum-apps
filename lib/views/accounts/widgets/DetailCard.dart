import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

class DetailCard extends StatelessWidget {
  bool editable;

  DetailCard({super.key, required this.editable});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      return Container(
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
                    AppStrings.txtMyDetails.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                        color:
                            Theme.of(context).colorScheme.secondary),
                  ),
                ),
                editable
                    ? InkWell(
                        onTap: () {
                          provider.updateSelectedEditScreen(
                              UserInfoProvider.DETAILS_EDIT_SCREEN);
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
            Text(
              userName(provider),
              style: TextStyle(
                  color: editable
                      ? Theme.of(context).textSelectionTheme.selectionColor
                      : Theme.of(context)
                          .textSelectionTheme
                          .selectionColor
                          ?.withValues(alpha: 0.7)),
            ),
            AppDimens.shape_5,
            Text(
              "DOB ${editable ? AppHelper.formatDate(provider.tempUser!.dateOfBirth) : "**/**/****"}",
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
      );
    });
  }

  String userName(UserInfoProvider provider) {
    if (editable) {
      return "${provider.tempUser != null && provider.tempUser!.firstName != null ? provider.tempUser!.firstName : ""} ${(provider.tempUser != null && provider.tempUser!.lastName != null) ? provider.tempUser!.lastName! : ""}";
    } else {
      return "${provider.getUserInfo != null && provider.getUserInfo!.firstName != null ? provider.getUserInfo!.firstName : ""} ${(provider.getUserInfo != null && provider.getUserInfo!.lastName != null && provider.getUserInfo!.lastName!.length > 2) ? provider.getUserInfo!.lastName!.replaceRange(1, provider.getUserInfo!.lastName!.length, "*" * provider.getUserInfo!.lastName!.length) : ""}";
    }
  }
}
