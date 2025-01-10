import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';

class IconTextWidget extends StatelessWidget {
  int orientation;
  static int HORIZONTAL = 1;
  static int VERTICAL = 2;

  IconData? icon;
  double? iconSize;
  Color? iconColor;
  Decoration? decoration;
  String? text;
  double? textSize;
  Color? textColor;
  EdgeInsetsGeometry? margin;
  Function()? onClick;
  Function(TapDownDetails value)? onTapDown;
  Function(TapUpDetails value)? onTapUp;

  IconTextWidget(
      {super.key,
      required this.orientation,
      this.icon,
      this.text,
      this.iconColor,
      this.textColor,
      this.iconSize,
      this.textSize,
      this.decoration,
      this.margin,
      this.onClick,
      this.onTapUp,
      this.onTapDown});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: margin,
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTap: onClick,
        child: Center(
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
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  text ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      color: textColor,
                      fontSize: AppHelper.getFontSize(context, 10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
