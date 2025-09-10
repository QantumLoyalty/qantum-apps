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
        return AppColors.mhbc_sf_color;
      case Flavor.montaukTavern:
        return AppColors.mhbc_back_color;
      case Flavor.hogansReward:
        return AppColors.hr_button_color;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  static Color getPointsBalanceBorder(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.clh:
        return AppColors.clh_sf_color;
      case Flavor.mhbc:
        return AppColors.white;
      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color getSeeAllBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return AppColors.mhbc_back_color_2;
      case Flavor.montaukTavern:
        return AppColors.mhbc_back_color;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  static Color getSeeAllBorder(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.clh:
        return AppColors.clh_sf_color;
      case Flavor.mhbc:
        return AppColors.mhbc_back_color_2;
      case Flavor.hogansReward:
        return AppColors.hr_back_color;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color? getAccountBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.clh || Flavor.montaukTavern:
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
      case Flavor.montaukTavern:
        return AppColors.mt_back_color_3;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getProfileDialogCardTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.clh:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).disabledColor;
    }
  }

  static Color getProfileDialogTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getProfileDialogImage(BuildContext context) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return Theme.of(context).primaryColor;
      case Flavor.hogansReward:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color? getCustomScaffoldBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.clh:
        return Theme.of(context).primaryColor;
      case Flavor.montaukTavern:
        return null;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  static Color? getPointsBalanceTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.hogansReward:
        return AppColors.white;
      default:
        return Theme.of(context).disabledColor;
    }
  }

  static ButtonStyle getDeleteButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.maxx:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.starReward:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));

      case Flavor.mhbc:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.clh:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.montaukTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.hogansReward:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));

      default:
        return const ButtonStyle();
    }
  }

  static Color getTextFieldBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return Theme.of(context).cardColor.withValues(alpha: 0.15);
      default:
        return Theme.of(context).cardColor;
    }
  }

  static Color getTextFieldTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return Theme.of(context).textSelectionTheme.selectionColor!;
      default:
        return AppColors.black;
    }
  }

  static ButtonStyle getUpdateInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.maxx:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(AppColors.white));
      case Flavor.starReward:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.mhbc:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.clh:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.montaukTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.hogansReward:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(Theme.of(context)
                .buttonTheme
                .colorScheme!
                .primary
                .withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));

      default:
        return ButtonStyle();
    }
  }

  static Color getUpdateInfoTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
      case Flavor.maxx:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;
      case Flavor.starReward:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;

      case Flavor.hogansReward:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static ButtonStyle getCancelInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.maxx:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.starReward:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));

      case Flavor.mhbc:
        return ButtonStyle(
            shadowColor:
            WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.clh:
        return ButtonStyle(
            shadowColor:
            WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.montaukTavern:
        return ButtonStyle(
            shadowColor:
            WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.hogansReward:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(Theme.of(context)
                .buttonTheme
                .colorScheme!
                .primary
                .withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));

      default:
        return const ButtonStyle();
    }
  }



}
