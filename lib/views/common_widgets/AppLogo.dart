import 'package:flutter/material.dart';
import '/core/utils/AppHelper.dart';

import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';

class Applogo extends StatelessWidget {
  bool? hideTopLine = false;
  double? iconPadding;
  double? customIconHeight;
  double? customIconWidth;

  Applogo(
      {super.key,
      this.hideTopLine,
      this.iconPadding,
      this.customIconHeight,
      this.customIconWidth});

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
                  iconPadding != null
                      ? AppDimens.getCustomBoxShape(iconPadding!)
                      : AppDimens.shape_10
                ],
              ),
        Image.asset(AppIcons.app_logo,
            width: customIconWidth ?? AppHelper.getAppIconSize(context).width,
            height:
                customIconHeight ?? AppHelper.getAppIconSize(context).height),
        iconPadding != null
            ? AppDimens.getCustomBoxShape(iconPadding!)
            : AppDimens.shape_10
      ],
    );
  }
}
