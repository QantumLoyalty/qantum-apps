import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';

class IconTextWidget extends StatelessWidget {
  int orientation;
  static int HORIZONTAL = 1;
  static int VERTICAL = 2;

  IconData? icon;
  double? iconSize;
  Color? iconColor;

  String? text;
  double? textSize;
  Color? textColor;

  IconTextWidget(
      {super.key,
      required this.orientation,
      this.icon,
      this.text,
      this.iconColor,
      this.textColor,
      this.iconSize,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction:
            (orientation == HORIZONTAL) ? Axis.horizontal : Axis.vertical,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          AppDimens.shape_5,
          Text(
            text ?? "",
            style: TextStyle(color: textColor, fontSize: textSize),
          )
        ],
      ),
    );
  }
}
