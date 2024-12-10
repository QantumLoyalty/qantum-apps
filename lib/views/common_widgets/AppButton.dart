import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function() onClick;
  Color? backgroundColor;
  Color? textColor;

  AppButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            backgroundColor: WidgetStatePropertyAll(backgroundColor ??
                Theme.of(context).buttonTheme.colorScheme!.primary)),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: textColor ??
                Theme.of(context).buttonTheme.colorScheme!.secondary,
          ),
        ));
  }
}
