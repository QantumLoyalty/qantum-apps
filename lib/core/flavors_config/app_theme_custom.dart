import 'package:flutter/material.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';

import '/view_models/HomeProvider.dart';
import '../utils/AppColors.dart';
import '../utils/AppStrings.dart';
import 'flavor_config.dart';

class AppThemeCustom {
  static ButtonStyle getMoreInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.qantumClub:
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
      case Flavor.qantum || Flavor.qantumClub:
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
      case Flavor.aceRewards:
        return Theme.of(context).primaryColorDark;
      case Flavor.bluewater:
        return Theme.of(context).canvasColor;

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
      case Flavor.woollahra:
        return Theme.of(context).scaffoldBackgroundColor;
      case Flavor.bluewater:
        return Theme.of(context).canvasColor;
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
        return AppColors.mt_back_color;
      case Flavor.northShoreTavern:
        return AppColors.nst_back_color;
      case Flavor.aceRewards:
        return AppColors.ar_back_color_2;
      case Flavor.queens || Flavor.brisbane || Flavor.woollahra:
        return Theme.of(context).primaryColor;

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
      case Flavor.northShoreTavern:
        return AppColors.nst_back_color;
      case Flavor.queens || Flavor.brisbane:
        return Theme.of(context).primaryColor;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color? getAccountBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.clh || Flavor.montaukTavern ||Flavor.drinkRewards:
        return Theme.of(context).scaffoldBackgroundColor;
      case Flavor.flinders:
        return Theme.of(context).canvasColor;

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
      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getProfileDialogCardTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.clh || Flavor.brisbane || Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.kingscliff:
        return AppColors.kc_scaffold_bg_color;
      case Flavor.drinkRewards:
        return AppColors.dr_button_color;

      default:
        return Theme.of(context).disabledColor;
    }
  }

  static Color getProfileEditHeadingTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.kingscliff:
        return Theme.of(context).dividerColor;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getProfileDialogTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.brisbane || Flavor.flinders:
        return AppColors.white;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getProfileDialogImage(BuildContext context) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.hogansReward:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
      case Flavor.brisbane || Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color? getCustomScaffoldBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc ||
            Flavor.clh ||
            Flavor.northShoreTavern ||
            Flavor.queens ||
            Flavor.brisbane ||
            Flavor.flinders:
        return Theme.of(context).primaryColor;
      case Flavor.montaukTavern:
        return null;
      case Flavor.aceRewards:
        return null;
      case Flavor.drinkRewards:
        return null;

      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  static Color? getPointsBalanceTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.brisbane || Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color? getPointsBalancePointTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.hogansReward ||
            Flavor.northShoreTavern ||
            Flavor.aceRewards ||
            Flavor.aceRewards ||
            Flavor.bluewater:
        return AppColors.white;

      default:
        return Theme.of(context).disabledColor;
    }
  }

  static ButtonStyle getDeleteButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.qantumClub || Flavor.drinkRewards:
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
      case Flavor.starReward || Flavor.kingscliff:
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
      case Flavor.brisbane:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));

      default:
        return const ButtonStyle();
    }
  }

  static Color getTextFieldBackground(BuildContext context, {bool? isShadow}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.queens ||
            Flavor.drinkRewards:
        return Theme.of(context).cardColor.withValues(alpha: 0.20);
      case Flavor.kingscliff:
        return isShadow != null
            ? AppColors.white_shadow
            : Theme.of(context).cardColor;
      default:
        return Theme.of(context).cardColor;
    }
  }

  static Color getHintTextFieldColor(BuildContext context, {bool? isShadow}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.kingscliff:
        return isShadow != null
            ? AppColors.white.withOpacity(0.39)
            : Theme.of(context).hintColor;
      default:
        return Theme.of(context).hintColor;
    }
  }

  static Color getTextFieldTextColor(BuildContext context, {bool? isShadow}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.queens ||
            Flavor.drinkRewards:
        return Theme.of(context).textSelectionTheme.selectionColor!;
      case Flavor.kingscliff:
        return isShadow != null ? AppColors.white : AppColors.black;
      default:
        return AppColors.black;
    }
  }

  static ButtonStyle getUpdateInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.qantumClub || Flavor.drinkRewards:
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
      case Flavor.starReward || Flavor.kingscliff:
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
      case Flavor.northShoreTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor));
      case Flavor.aceRewards ||
            Flavor.queens ||
            Flavor.bluewater ||
            Flavor.woollahra:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.brisbane:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.flinders:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary),
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
      case Flavor.qantum || Flavor.qantumClub ||Flavor.drinkRewards:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
      case Flavor.maxx:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;
      case Flavor.starReward:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;

      case Flavor.hogansReward || Flavor.brisbane:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static Color getAllMenuItemsTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getAllMenuItemsBorderColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).iconTheme.color!;
    }
  }

  static Color getAlertDialogTextButtonColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.flinders:
        return Theme.of(context).scaffoldBackgroundColor;

      default:
        return Theme.of(context).primaryColor;
    }
  }

  static Color getCancelInfoTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.brisbane:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static ButtonStyle getCancelInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.qantumClub ||Flavor.drinkRewards:
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
      case Flavor.starReward || Flavor.kingscliff:
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
      case Flavor.northShoreTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor));
      case Flavor.aceRewards ||
            Flavor.queens ||
            Flavor.bluewater ||
            Flavor.woollahra:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.brisbane:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.flinders:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      default:
        return const ButtonStyle();
    }
  }

  static Color? getCustomHomeButtonsIconStyle(
      BuildContext context,
      HomeProvider provider,
      UserInfoProvider userInfoProvider,
      String itemName) {
    if ((itemName == AppStrings.txtSeeAll &&
        (provider.moreButtonsMap == null ||
            provider.moreButtonsMap!.isEmpty))) {
      return ((provider.moreButtonsMap == null ||
              provider.moreButtonsMap!.isEmpty))
          ? Colors.transparent
          : null;
    } else {
      Flavor selectedFlavor = FlavorConfig.instance.flavor!;

      switch (selectedFlavor) {
        case Flavor.montaukTavern:
          return (provider.homeNavigationList[0].name == itemName ||
                  provider.homeNavigationList[2].name == itemName)
              ? Colors.transparent
              : (userInfoProvider.getUserInfo != null &&
                      userInfoProvider.getUserInfo!.isUserStatusCancelled())
                  ? AppColors.disable_color
                  : null;
        case Flavor.clh:
          return (provider.homeNavigationList[0].name == itemName ||
                  provider.homeNavigationList[2].name == itemName)
              ? Colors.transparent
              : (userInfoProvider.getUserInfo != null &&
                      userInfoProvider.getUserInfo!.isUserStatusCancelled())
                  ? AppColors.disable_color
                  : null;
        case Flavor.brisbane:
          return (provider.homeNavigationList[2].name == itemName)
              ? Colors.transparent
              : (userInfoProvider.getUserInfo != null &&
                      userInfoProvider.getUserInfo!.isUserStatusCancelled())
                  ? AppColors.disable_color
                  : Theme.of(context).buttonTheme.colorScheme!.primary;
        case Flavor.woollahra:
          return (provider.homeNavigationList[2].name == itemName)
              ? Colors.transparent
              : (userInfoProvider.getUserInfo != null &&
                      userInfoProvider.getUserInfo!.isUserStatusCancelled())
                  ? AppColors.disable_color
                  : null;
        case Flavor.northShoreTavern ||
              Flavor.starReward ||
              Flavor.queens ||
              Flavor.mhbc ||
              Flavor.hogansReward ||
              Flavor.bluewater ||
              Flavor.flinders ||
              Flavor.aceRewards ||
              Flavor.kingscliff ||
                  Flavor.drinkRewards:
          return (provider.homeNavigationList[2].name == itemName)
              ? Colors.transparent
              : (userInfoProvider.getUserInfo != null &&
                      userInfoProvider.getUserInfo!.isUserStatusCancelled())
                  ? AppColors.disable_color
                  : null;

        default:
          return (userInfoProvider.getUserInfo != null &&
                  userInfoProvider.getUserInfo!.isUserStatusCancelled())
              ? AppColors.disable_color
              : null;
      }
    }
  }

  static Color? getAccountSectionCustomCard(
      BuildContext context, bool isEditable) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.flinders:
        {
          if (isEditable) {
            return AppColors.fw_back_color_3;
          } else {
            return Theme.of(context).cardColor.withValues(alpha: 0.10);
          }
        }

      default:
        return Theme.of(context).cardColor.withValues(alpha: 0.10);
    }
  }

  static Color? getAccountSectionItemStyle(BuildContext context,
      {bool? isCommunication,bool? isHeadingCommunication}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern || Flavor.brisbane || Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.aceRewards || Flavor.queens:
        return isCommunication != null
            ? AppColors.white
            : Theme.of(context).primaryColorDark;
      case Flavor.flinders:
        return AppColors.white;
      case Flavor.kingscliff:
        return isCommunication != null
            ? AppColors.white
            : Theme.of(context).primaryColorDark;
      case Flavor.drinkRewards:
        return (isCommunication != null && isHeadingCommunication !=null)
            ? AppColors.dr_button_color
            : Theme.of(context).textSelectionTheme.selectionColor;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color? getAppButtonTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.brisbane:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static Color? getAccountSectionDeleteTextStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern || Flavor.queens || Flavor.brisbane:
        return Theme.of(context).primaryColor;
      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color? getUserInfoItemStyle(BuildContext context, bool isFromEdit) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern:
        if (isFromEdit) {
          return Theme.of(context).textSelectionTheme.selectionColor;
        } else {
          return Theme.of(context).primaryColor;
        }
      case Flavor.aceRewards:
        if (isFromEdit) {
          return Theme.of(context).textSelectionTheme.selectionColor;
        } else {
          return Theme.of(context).primaryColorDark;
        }
      case Flavor.queens:
        if (isFromEdit) {
          return Theme.of(context).textSelectionTheme.selectionColor;
        } else {
          return AppColors.black;
        }
      case Flavor.brisbane:
        if (isFromEdit) {
          return Theme.of(context).textSelectionTheme.selectionColor;
        } else {
          return Theme.of(context).primaryColor;
        }
      case Flavor.woollahra:
        if (isFromEdit) {
          return Theme.of(context).textSelectionTheme.selectionColor;
        } else {
          return Theme.of(context).primaryColor;
        }

      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static BoxBorder? getCustomHomeButtonsBorderStyle(
      BuildContext context,
      HomeProvider provider,
      UserInfoProvider userInfoProvider,
      String itemName) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.montaukTavern:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? null
            : (userInfoProvider.getUserInfo != null &&
                    userInfoProvider.getUserInfo!.isUserStatusCancelled())
                ? Border.all(color: AppColors.disable_color, width: 1.5)
                : Border.all(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    width: 1.5);
      case Flavor.clh:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? null
            : (userInfoProvider.getUserInfo != null &&
                    userInfoProvider.getUserInfo!.isUserStatusCancelled())
                ? Border.all(color: AppColors.disable_color, width: 1.5)
                : Border.all(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    width: 1.5);

      case Flavor.northShoreTavern ||
            Flavor.starReward ||
            Flavor.queens ||
            Flavor.brisbane ||
            Flavor.hogansReward ||
            Flavor.woollahra ||
            Flavor.bluewater ||
            Flavor.flinders ||
            Flavor.aceRewards ||
            Flavor.mhbc ||
            Flavor.kingscliff ||
            Flavor.drinkRewards:
        return (provider.homeNavigationList[2].name == itemName)
            ? null
            : (userInfoProvider.getUserInfo != null &&
                    userInfoProvider.getUserInfo!.isUserStatusCancelled())
                ? Border.all(color: AppColors.disable_color, width: 1.5)
                : Border.all(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    width: 1.5);

      default:
        return (userInfoProvider.getUserInfo != null &&
                userInfoProvider.getUserInfo!.isUserStatusCancelled())
            ? Border.all(color: AppColors.disable_color, width: 1.5)
            : Border.all(
                color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                width: 1.5);
    }
  }

  static Color? getCustomHomeButtonsTextStyle(
      BuildContext context,
      HomeProvider provider,
      UserInfoProvider userInfoProvider,
      String itemName) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.montaukTavern:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (userInfoProvider.getUserInfo != null &&
                    userInfoProvider.getUserInfo!.isUserStatusCancelled())
                ? AppColors.disable_color
                : Theme.of(context).textSelectionTheme.selectionColor;
      case Flavor.clh:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (userInfoProvider.getUserInfo != null &&
                    userInfoProvider.getUserInfo!.isUserStatusCancelled())
                ? AppColors.disable_color
                : Theme.of(context).textSelectionTheme.selectionColor;

      case Flavor.northShoreTavern ||
            Flavor.starReward ||
            Flavor.queens ||
            Flavor.hogansReward ||
            Flavor.mhbc ||
            Flavor.brisbane ||
            Flavor.woollahra ||
            Flavor.bluewater ||
            Flavor.flinders ||
            Flavor.aceRewards ||
            Flavor.kingscliff ||
            Flavor.drinkRewards:
        return (provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (userInfoProvider.getUserInfo != null &&
                    userInfoProvider.getUserInfo!.isUserStatusCancelled())
                ? AppColors.disable_color
                : Theme.of(context).textSelectionTheme.selectionColor;

      default:
        return (userInfoProvider.getUserInfo != null &&
                userInfoProvider.getUserInfo!.isUserStatusCancelled())
            ? AppColors.disable_color
            : Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color getEditDetailsColor(BuildContext context,{bool? isText }) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.brisbane || Flavor.flinders:
        return AppColors.white;
      case Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.drinkRewards:
        return isText!=null?Theme.of(context).textSelectionTheme.selectionColor!:AppColors.dr_button_color;
      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getMyProfileCardBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern:
        return AppColors.nst_back_color;
      case Flavor.woollahra:
        return Theme.of(context).canvasColor;
      case Flavor.kingscliff:
        return AppColors.kc_primary_color_dark;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  static Color getCloseBtnDialogColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.montaukTavern ||
            Flavor.aceRewards ||
            Flavor.woollahra ||
            Flavor.bluewater:
        return Theme.of(context).primaryColorDark;
      case Flavor.flinders:
        return Theme.of(context).scaffoldBackgroundColor;
      case Flavor.queens:
        return AppColors.black;
      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color getCardDialogsTextColor(BuildContext context) {
    /*Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.queens:
        {
          return Theme.of(context).primaryColorDark;
        }

      default:
        return AppColors.white;
    }*/
    return AppColors.white;
  }

  static Color getTNCTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.starReward:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }
}
