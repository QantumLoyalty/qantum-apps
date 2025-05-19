import 'package:flutter/material.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';

import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppIcons.dart';
import '../../../core/utils/AppStrings.dart';

class AccountsAppBar extends StatelessWidget {
  bool showBackButton;
  String title;

  AccountsAppBar(
      {super.key, required this.showBackButton, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 25, bottom: 25, right: 25),
      child: Stack(
        children: [
          showBackButton
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    size: 28,
                    color: AppThemeCustom.getAccountHeaderColor(context),
                  ))
              : Container(),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                (title == AppStrings.txtMyAccount)
                    ? Image.asset(AppIcons.my_account,
                        width: 24,
                        height: 24,
                        color: AppThemeCustom.getAccountHeaderColor(context))
                    : Container(),
                AppDimens.shape_10,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppThemeCustom.getAccountHeaderColor(context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
