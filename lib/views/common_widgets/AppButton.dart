import 'package:flutter/material.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import '/core/utils/AppDimens.dart';

class AppButton extends StatelessWidget {
  String text;
  Function() onClick;
  Color? backgroundColor;
  Color? textColor;
  Icon? icon;

  AppButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.icon,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          style: AppThemeCustom.getAppButtonStyle(context, backgroundColor),
          onPressed: onClick,
          child: icon == null
              ? getText(context)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [getText(context), AppDimens.shape_5, icon!],
                )),
    );
  }

  Widget getText(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: textColor ?? AppThemeCustom.getAppButtonTextColor(context),
        ),
      );
}
