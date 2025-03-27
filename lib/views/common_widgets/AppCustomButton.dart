import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';

class AppCustomButton extends StatelessWidget {
  String text;
  Function() onClick;
  Color? backgroundColor;
  Color? textColor;
  Icon? icon;
  ButtonStyle? style;

  AppCustomButton(
      {super.key, required this.text, required this.onClick,this.textColor, this.icon,this.style});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          style: style ??
              ButtonStyle(
                  shadowColor: WidgetStatePropertyAll(
                      Colors.black.withValues(alpha: 0.7)),
                  elevation: const WidgetStatePropertyAll(20),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onSecondary),
                      borderRadius: BorderRadius.circular(80))),
                  backgroundColor: WidgetStatePropertyAll(backgroundColor ??
                      Theme.of(context).buttonTheme.colorScheme!.primary)),
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
          color:
              textColor ?? Theme.of(context).buttonTheme.colorScheme!.onPrimary,
        ),
      );
}
