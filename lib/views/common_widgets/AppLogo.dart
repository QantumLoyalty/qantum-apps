import 'package:flutter/material.dart';

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
            : const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                  ),
                  AppDimens.shape_20
                ],
              ),
        Image.asset(
          AppIcons.app_logo,
          width: 64,
          height: 64,
        ),
        AppDimens.shape_15,
      ],
    );
  }
}
