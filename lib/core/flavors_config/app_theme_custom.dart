import 'package:flutter/material.dart';
import '../utils/AppColors.dart';
import 'flavor_config.dart';

class AppThemeCustom {
  static ButtonStyle getMoreInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return TextButton.styleFrom(
            minimumSize: const Size(85, 30),
            padding: EdgeInsets.zero,
            elevation: 20,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColorDark),
                borderRadius: BorderRadius.circular(80)),
            backgroundColor: AppColors.qa_back_color_2);
      case Flavor.maxx:
        return TextButton.styleFrom(
            minimumSize: const Size(85, 30),
            padding: EdgeInsets.zero,
            elevation: 20,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80)),
            backgroundColor: AppColors.white);
      case Flavor.starReward:
        return TextButton.styleFrom(
            minimumSize: const Size(85, 30),
            padding: EdgeInsets.zero,
            elevation: 20,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80)),
            backgroundColor: AppColors.white);
      case Flavor.mhbc:
        return TextButton.styleFrom(
            minimumSize: const Size(85, 30),
            padding: EdgeInsets.zero,
            elevation: 20,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80)),
            backgroundColor: AppColors.white);

      default:
        return const ButtonStyle();
    }
  }

  static Color getMoreInfoTextStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return AppColors.white;
      case Flavor.maxx:
        return AppColors.max_button_color;
      case Flavor.starReward:
        return AppColors.sr_back_color;
      case Flavor.mhbc:
        return AppColors.mhbc_back_color;

      default:
        return AppColors.white;
    }
  }

  static ButtonStyle getRedeemButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size(85, 30)),
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.4)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor));
      default:
        return ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size(85, 30)),
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.4)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
    }
  }

  static Color getRedeemTextStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return AppColors.mhbc_back_color;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getPointsBalanceBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return AppColors.mhbc_back_color;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  static Color? getAccountBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).scaffoldBackgroundColor;
      default:
        return null;
    }
  }

  static Color getAccountHeaderColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getProfileDialogCardTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).disabledColor;
    }
  }static Color getProfileDialogTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getCustomScaffoldBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }
}
