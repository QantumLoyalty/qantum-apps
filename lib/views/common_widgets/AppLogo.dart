import 'package:flutter/material.dart';
import '/core/utils/AppHelper.dart';

import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';

class Applogo extends StatelessWidget {
  bool? hideTopLine = false;

  Applogo({super.key, this.hideTopLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppDimens.shape_10,
        (hideTopLine != null && hideTopLine!)
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                    color: Theme.of(context).dividerColor,
                  ),
                  AppDimens.shape_20
                ],
              ),
        Image.asset(AppIcons.app_logo,
            width: AppHelper.getAppIconSize(context).width,
            height: AppHelper.getAppIconSize(context).height),
        AppDimens.shape_20
      ],
    );
  }
}
