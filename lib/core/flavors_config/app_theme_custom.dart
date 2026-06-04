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
            backgroundColor: AppColors.qa_primary_color_dark);
      case Flavor.maxx || Flavor.maxClub:
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
      case Flavor.maxx || Flavor.maxClub:
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
      case Flavor.senseOfTaste || Flavor.bobsBulkBooze:
        return Theme.of(context).cardColor;
      case Flavor.mannumClub:
        return AppColors.mc_back_color;
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
      case Flavor.wonthaggi:
        return Theme.of(context).primaryColor;

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
      case Flavor.brisbane ||
            Flavor.woollahra ||
            Flavor.wonthaggi ||
            Flavor.mosaic:
        return Theme.of(context).primaryColor;
      case Flavor.senseOfTaste:
        return AppColors.sot_card_color;
      case Flavor.bobsBulkBooze:
        return AppColors.bob_back_color;
      case Flavor.mannumClub:
        return AppColors.mc_back_color;
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
      case Flavor.brisbane:
        return Theme.of(context).primaryColor;
      case Flavor.mannumClub:
        return AppColors.mc_button_color;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color? getAccountBackground(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc || Flavor.clh || Flavor.montaukTavern:
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
      case Flavor.starReward:
        return Theme.of(context).textSelectionTheme.selectionColor!;
      case Flavor.kingscliff:
        return AppColors.kc_scaffold_bg_color;
      case Flavor.drinkRewards:
        return AppColors.dr_button_color;
      case Flavor.edp:
        return AppColors.edp_back_color;
      case Flavor.senseOfTaste:
        return AppColors.sot_back_color;
      case Flavor.bobsBulkBooze:
        return AppColors.bob_back_color;
      case Flavor.mannumClub:
        return AppColors.mc_back_color;
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
      case Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.brisbane ||
            Flavor.flinders ||
            Flavor.wonthaggi ||
            Flavor.mhbc ||
            Flavor.mosaic:
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
      case Flavor.brisbane ||
            Flavor.flinders ||
            Flavor.wonthaggi ||
            Flavor.mosaic:
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
            Flavor.brisbane ||
            Flavor.flinders ||
            Flavor.wonthaggi ||
            Flavor.senseOfTaste ||
            Flavor.bobsBulkBooze ||
            Flavor.woollahra ||
            Flavor.mosaic ||
            Flavor.mannumClub:
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
      case Flavor.brisbane ||
            Flavor.flinders ||
            Flavor.wonthaggi ||
            Flavor.mosaic:
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
            Flavor.bluewater ||
            Flavor.mosaic:
        return AppColors.white;

      case Flavor.edp:
        return AppColors.edp_button_color;
      case Flavor.mannumClub:
        return AppColors.mc_button_color;

      default:
        return Theme.of(context).disabledColor;
    }
  }

  static Color getTextFieldBackground(BuildContext context, {bool? isShadow}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.qantumClub:
        return Theme.of(context).cardColor.withValues(alpha: 0.20);
      case Flavor.kingscliff:
        return isShadow != null
            ? AppColors.white_shadow
            : Theme.of(context).cardColor;
      case Flavor.drinkRewards:
        return AppColors.dr_box_shadow;
      case Flavor.edp:
        return AppColors.edp_textformField_background_color;
      case Flavor.mannumClub:
        return AppColors.white_shadow;
      case Flavor.bobsBulkBooze || Flavor.senseOfTaste:
        return AppColors.white.withOpacity(0.39);
      default:
        return Theme.of(context).cardColor;
    }
  }

  static Color getContainerBorderColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.drinkRewards:
        return AppColors.transparent;
      case Flavor.kingscliff || Flavor.maxClub || Flavor.maxx:
        return AppColors.white.withOpacity(0.1);
      default:
        return Theme.of(context).dividerColor;
    }
  }

  static Color? getHomeScreenProfileIconColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.drinkRewards || Flavor.senseOfTaste || Flavor.bobsBulkBooze:
        return AppColors.white;
      default:
        return Theme.of(context).iconTheme.color;
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

  static Color getTextFormFieldInnerDividerColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.kingscliff:
        return AppColors.white;
      case Flavor.maxClub || Flavor.maxx:
        return AppColors.max_hint_text_color;
      default:
        return Theme.of(context).dividerColor;
    }
  }

  static Color getTextFieldTextColor(BuildContext context, {bool? isShadow}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.drinkRewards ||
            Flavor.edp ||
            Flavor.senseOfTaste ||
            Flavor.mosaic ||
            Flavor.mannumClub:
        return Theme.of(context).textSelectionTheme.selectionColor!;
      case Flavor.kingscliff:
        return isShadow != null ? AppColors.white : AppColors.black;
      case Flavor.bobsBulkBooze:
        return AppColors.white;
      default:
        return AppColors.black;
    }
  }

  static ButtonStyle getUpdateInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.drinkRewards ||
            Flavor.wonthaggi ||
            Flavor.edp ||
            Flavor.senseOfTaste ||
            Flavor.mosaic ||
            Flavor.mannumClub ||
            Flavor.bobsBulkBooze:
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
      case Flavor.maxx || Flavor.maxClub:
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
      case Flavor.aceRewards || Flavor.bluewater || Flavor.woollahra:
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
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.drinkRewards ||
            Flavor.starReward:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
      case Flavor.maxx || Flavor.maxClub:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;
      case Flavor.wonthaggi:
        return Theme.of(context).buttonTheme.colorScheme!.secondary;

      case Flavor.hogansReward || Flavor.brisbane || Flavor.mosaic:
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
      case Flavor.senseOfTaste:
        return AppColors.sot_button_color;
      case Flavor.bobsBulkBooze:
        return AppColors.bob_button_color;
      case Flavor.mannumClub:
        return AppColors.mc_button_color;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getAllMenuItemsBorderColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.flinders:
        return AppColors.white;
      case Flavor.mannumClub:
        return AppColors.mc_button_color;
      default:
        return Theme.of(context).iconTheme.color!;
    }
  }

  static Color getAlertDialogTextButtonColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.flinders || Flavor.mosaic:
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
      case Flavor.edp:
        return AppColors.edp_button_color;
      case Flavor.mannumClub:
        return AppColors.mc_button_color;
      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static ButtonStyle getCancelInfoButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.drinkRewards ||
            Flavor.wonthaggi ||
            Flavor.edp ||
            Flavor.senseOfTaste ||
            Flavor.mosaic ||
            Flavor.mannumClub:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.maxx || Flavor.maxClub || Flavor.bobsBulkBooze:
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
      case Flavor.aceRewards || Flavor.bluewater || Flavor.woollahra:
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

  static Color? getHomeButtonsIconColor(
    BuildContext context,
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
    String itemName,
    bool isSelected,
  ) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    final bool isCancelled = userInfoProvider.getUserInfo != null &&
        userInfoProvider.getUserInfo!.isUserStatusCancelled();
    // Special case: See All hidden
    if (itemName == AppStrings.txtSeeAll &&
        (provider.moreButtonsMap == null || provider.moreButtonsMap!.isEmpty)) {
      return Colors.transparent;
    }

    // 👉 SELECTED STATE
    if (isSelected) {
      switch (selectedFlavor) {
        case Flavor.senseOfTaste:
        case Flavor.edp:
        case Flavor.bobsBulkBooze:
          return AppColors.white;
        case Flavor.maxClub || Flavor.maxx:
          return AppColors.max_back_color_3;
        case Flavor.mosaic || Flavor.mannumClub:
          return (provider.homeNavigationList[2].name == itemName)
              ? Colors.transparent
              : AppColors.white;
        case Flavor.wonthaggi:
          return AppColors.wt_text_color;
        default:
          return AppColors.white;
      }
    }

    // 👉 DEFAULT STATE
    switch (selectedFlavor) {
      case Flavor.montaukTavern:
      case Flavor.clh:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (isCancelled ? AppColors.disable_color : null);

      case Flavor.brisbane:
        return (provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (isCancelled
                ? AppColors.disable_color
                : Theme.of(context).buttonTheme.colorScheme!.primary);

      case Flavor.woollahra:
        return (provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (isCancelled ? AppColors.disable_color : null);

      case Flavor.northShoreTavern:
      case Flavor.mhbc:
      case Flavor.hogansReward:
      case Flavor.bluewater:
      case Flavor.flinders:
      case Flavor.aceRewards:
      case Flavor.kingscliff:
      case Flavor.drinkRewards:
      case Flavor.wonthaggi:
      case Flavor.mosaic:
        return (provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (isCancelled ? AppColors.disable_color : null);

      case Flavor.edp:
        return (provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : AppColors.edp_button_color;

      case Flavor.senseOfTaste:
        return isCancelled
            ? AppColors.sot_hint_text_color
            : AppColors.sot_button_color;

      case Flavor.bobsBulkBooze:
        return AppColors.bob_button_color;
      case Flavor.mannumClub:
        return provider.homeNavigationList[2].name == itemName
            ? Colors.transparent
            : AppColors.mc_button_color;
      default:
        return isCancelled ? AppColors.disable_color : null;
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
      case Flavor.wonthaggi:
        {
          if (isEditable) {
            return Theme.of(context).cardColor;
          } else {
            return Theme.of(context).cardColor.withValues(alpha: 0.10);
          }
        }
      case Flavor.bobsBulkBooze || Flavor.senseOfTaste || Flavor.woollahra:
        return AppColors.white_opacity;
      case Flavor.mosaic:
        {
          if (isEditable) {
            return Theme.of(context).cardColor;
          } else {
            return AppColors.white.withOpacity(0.27);
          }
        }
      default:
        return Theme.of(context).cardColor.withValues(alpha: 0.10);
    }
  }

  static Color? getAccountSectionItemStyle(BuildContext context,
      {bool? isCommunication, bool? isHeadingCommunication}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern || Flavor.brisbane || Flavor.woollahra:
        return Theme.of(context).primaryColor;
      case Flavor.aceRewards:
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
        return (isCommunication != null && isHeadingCommunication != null)
            ? AppColors.dr_button_color
            : Theme.of(context).textSelectionTheme.selectionColor;
      case Flavor.qantumClub || Flavor.qantum:
        return (isCommunication != null && isHeadingCommunication != null)
            ? AppColors.qa_disable_color
            : Theme.of(context).textSelectionTheme.selectionColor;
      case Flavor.wonthaggi:
        return (isCommunication != null && isHeadingCommunication != null)
            ? AppColors.wt_back_color
            : Theme.of(context).primaryColorDark;
      case Flavor.mosaic:
        return isCommunication != null
            ? AppColors.white
            : Theme.of(context).primaryColorDark;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color? getAppButtonTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.brisbane || Flavor.wonthaggi || Flavor.mosaic:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static Color? getAccountSectionDeleteTextStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern ||
            Flavor.brisbane ||
            Flavor.wonthaggi ||
            Flavor.mosaic:
        return Theme.of(context).primaryColor;
      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color? getUserInfoItemStyle(
    BuildContext context,
    bool isFromEdit, {
    bool? isHeading,
  }) {
    final theme = Theme.of(context);
    final selectionColor = theme.textSelectionTheme.selectionColor;
    final primaryColor = theme.primaryColor;

    final flavor = FlavorConfig.instance.flavor!;

    // Common edit behavior
    if (isFromEdit &&
        flavor != Flavor.flinders &&
        flavor != Flavor.drinkRewards &&
        flavor != Flavor.edp &&
        flavor != Flavor.qantumClub &&
        flavor != Flavor.qantum &&
        flavor != Flavor.senseOfTaste &&
        flavor != Flavor.bobsBulkBooze &&
        flavor != Flavor.mannumClub &&
        flavor != Flavor.mosaic) {
      return selectionColor;
    }

    switch (flavor) {
      case Flavor.northShoreTavern:
      case Flavor.brisbane:
      case Flavor.woollahra:
      case Flavor.wonthaggi:
        return primaryColor;

      case Flavor.aceRewards:
        return isFromEdit ? selectionColor : theme.primaryColorDark;

      case Flavor.flinders:
        return AppColors.white;

      case Flavor.drinkRewards:
        return (isHeading == true) ? AppColors.dr_button_color : selectionColor;

      case Flavor.edp:
        return (isHeading == true && isFromEdit)
            ? AppColors.edp_button_color
            : selectionColor;

      case Flavor.qantumClub:
      case Flavor.qantum:
        return (isHeading == true)
            ? AppColors.qa_disable_color
            : selectionColor;
      case Flavor.senseOfTaste:
        return (isHeading == true && isFromEdit)
            ? AppColors.sot_button_color
            : selectionColor;
      case Flavor.bobsBulkBooze:
        return (isHeading == true && isFromEdit)
            ? AppColors.bob_button_color
            : selectionColor;
      case Flavor.mannumClub:
        return (isHeading == true && isFromEdit)
            ? AppColors.mc_button_color
            : selectionColor;
      case Flavor.mosaic:
        return isFromEdit ? AppColors.mh_button_color : AppColors.white;
      default:
        return selectionColor;
    }
  }

  static BoxBorder? getHomeButtonsBorder(
    BuildContext context,
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
    String itemName,
    bool isSelected,
  ) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    final bool isCancelled = userInfoProvider.getUserInfo != null &&
        userInfoProvider.getUserInfo!.isUserStatusCancelled();

    if (itemName == AppStrings.txtSeeAll &&
        (provider.moreButtonsMap == null || provider.moreButtonsMap!.isEmpty)) {
      return Border.all(color: Colors.transparent);
    }

    // 👉 SELECTED STATE
    if (isSelected &&
        (selectedFlavor == Flavor.senseOfTaste ||
            selectedFlavor == Flavor.edp ||
            selectedFlavor == Flavor.bobsBulkBooze ||
            selectedFlavor == Flavor.mannumClub ||
            selectedFlavor == Flavor.maxx ||
            selectedFlavor == Flavor.maxClub)) {
      // Special case for mannumClub
      if (selectedFlavor == Flavor.mannumClub &&
          provider.homeNavigationList[2].name == itemName) {
        return Border.all(color: Colors.transparent);
      }

      return Border.all(color: AppColors.white);
    }

    // 👉 DEFAULT STATE
    switch (selectedFlavor) {
      case Flavor.montaukTavern:
      case Flavor.clh:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? null
            : (isCancelled
                ? Border.all(color: AppColors.disable_color, width: 1.5)
                : Border.all(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    width: 1.5));

      case Flavor.northShoreTavern:
      case Flavor.brisbane:
      case Flavor.hogansReward:
      case Flavor.woollahra:
      case Flavor.bluewater:
      case Flavor.flinders:
      case Flavor.aceRewards:
      case Flavor.mhbc:
      case Flavor.kingscliff:
      case Flavor.drinkRewards:
      case Flavor.wonthaggi:
      case Flavor.edp:
      case Flavor.mosaic:
      case Flavor.mannumClub:
        return (provider.homeNavigationList[2].name == itemName)
            ? null
            : (isCancelled
                ? Border.all(color: AppColors.disable_color, width: 1.5)
                : Border.all(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    width: 1.5));

      case Flavor.bobsBulkBooze:
        return (isCancelled
            ? Border.all(color: AppColors.disable_color, width: 1.5)
            : Border.all(
                color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                width: 1.5));

      default:
        return isCancelled
            ? Border.all(color: AppColors.disable_color, width: 1.5)
            : Border.all(
                color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                width: 1.5);
    }
  }

  static Color getSelectedColorHomeButtonsText(
      HomeProvider provider, String itemName) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;

    switch (selectedFlavor) {
      case Flavor.senseOfTaste:
        {
          return AppColors.white;
        }
      case Flavor.edp:
        {
          return AppColors.white;
        }
      case Flavor.bobsBulkBooze:
        {
          return AppColors.white;
        }
      default:
        return AppColors.white;
    }
  }

  static Color? getHomeButtonsBackgroundColor(
    BuildContext context,
    HomeProvider provider,
    int index,
    String itemName,
    bool isSelected,
  ) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    if (itemName == AppStrings.txtSeeAll &&
        (provider.moreButtonsMap == null || provider.moreButtonsMap!.isEmpty)) {
      return Colors.transparent;
    }
    if (!isSelected) {
      return Colors.transparent;
    }

    // 👉 senseOfTaste → ALWAYS shadow (no index condition)
    if (selectedFlavor == Flavor.senseOfTaste ||
        selectedFlavor == Flavor.bobsBulkBooze) {
      return AppColors.button_shadow;
    }

    if (selectedFlavor == Flavor.maxx || selectedFlavor == Flavor.maxClub) {
      return AppColors.white;
    }

    // 👉 Other special flavors (keep index 2 exception)
    if (selectedFlavor == Flavor.edp) {
      return provider.homeNavigationList[2].name ==
              provider.homeNavigationList[index].name
          ? null
          : AppColors.button_shadow;
    }

    if (selectedFlavor == Flavor.mosaic) {
      return provider.homeNavigationList[2].name ==
              provider.homeNavigationList[index].name
          ? null
          : AppColors.mh_button_color;
    }
    if (selectedFlavor == Flavor.mannumClub) {
      return provider.homeNavigationList[2].name ==
              provider.homeNavigationList[index].name
          ? null
          : AppColors.button_shadow;
    }

    if (selectedFlavor == Flavor.wonthaggi) {
      return provider.homeNavigationList[2].name ==
              provider.homeNavigationList[index].name
          ? null
          : AppColors.wt_menu_background;
    }

    // 👉 Default flavors
    return Theme.of(context).iconTheme.color!.withValues(alpha: 0.5);
  }

  static Color? getHomeButtonsTextColor(
    BuildContext context,
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
    String itemName,
    bool isSelected,
  ) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    final bool isCancelled = userInfoProvider.getUserInfo != null &&
        userInfoProvider.getUserInfo!.isUserStatusCancelled();

    if (itemName == AppStrings.txtSeeAll &&
        (provider.moreButtonsMap == null || provider.moreButtonsMap!.isEmpty)) {
      return Colors.transparent;
    }

    // 👉 SELECTED STATE
    if (isSelected &&
        (selectedFlavor == Flavor.senseOfTaste ||
            selectedFlavor == Flavor.bobsBulkBooze ||
            selectedFlavor == Flavor.edp ||
            selectedFlavor == Flavor.mosaic ||
            selectedFlavor == Flavor.mannumClub ||
            selectedFlavor == Flavor.maxx ||
            selectedFlavor == Flavor.maxClub)) {
      if (selectedFlavor == Flavor.maxx || selectedFlavor == Flavor.maxClub) {
        return AppColors.max_back_color_3;
      }
      // Special case for mosaic
      if (selectedFlavor == Flavor.mosaic &&
          provider.homeNavigationList[2].name == itemName) {
        return Colors.transparent;
      }
      if (selectedFlavor == Flavor.mannumClub &&
          provider.homeNavigationList[2].name == itemName) {
        return Colors.transparent;
      }

      return AppColors.white;
    }

    // 👉 DEFAULT STATE
    switch (selectedFlavor) {
      case Flavor.montaukTavern:
      case Flavor.clh:
        return (provider.homeNavigationList[0].name == itemName ||
                provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (isCancelled
                ? AppColors.disable_color
                : Theme.of(context).textSelectionTheme.selectionColor);

      case Flavor.northShoreTavern:
      case Flavor.hogansReward:
      case Flavor.mhbc:
      case Flavor.brisbane:
      case Flavor.woollahra:
      case Flavor.bluewater:
      case Flavor.flinders:
      case Flavor.aceRewards:
      case Flavor.kingscliff:
      case Flavor.drinkRewards:
      case Flavor.wonthaggi:
      case Flavor.edp:
      case Flavor.mosaic:
        return (provider.homeNavigationList[2].name == itemName)
            ? Colors.transparent
            : (isCancelled
                ? AppColors.disable_color
                : Theme.of(context).textSelectionTheme.selectionColor);

      case Flavor.senseOfTaste:
        return isCancelled
            ? AppColors.disable_color
            : AppColors.sot_button_color;

      case Flavor.bobsBulkBooze:
        return isCancelled
            ? AppColors.disable_color
            : AppColors.bob_button_color;
      case Flavor.mannumClub:
        return provider.homeNavigationList[2].name == itemName
            ? Colors.transparent
            : (isCancelled
                ? AppColors.disable_color
                : AppColors.mc_button_color);
      default:
        return isCancelled
            ? AppColors.disable_color
            : Theme.of(context).textSelectionTheme.selectionColor;
    }
  }

  static Color getEditDetailsColor(BuildContext context, {bool? isText}) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.brisbane ||
            Flavor.flinders ||
            Flavor.wonthaggi ||
            Flavor.mosaic:
        return AppColors.white;
      case Flavor.woollahra || Flavor.mannumClub:
        return Theme.of(context).primaryColor;
      case Flavor.drinkRewards:
        return isText != null
            ? Theme.of(context).textSelectionTheme.selectionColor!
            : AppColors.dr_button_color;
      case Flavor.qantumClub || Flavor.qantum:
        return AppColors.qa_disable_color;
      case Flavor.edp:
        return AppColors.edp_back_color_2;
      case Flavor.senseOfTaste:
        return AppColors.black;
      case Flavor.bobsBulkBooze:
        return AppColors.bob_back_color;
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
      case Flavor.edp:
        return AppColors.edp_button_color;
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
      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color getOffersExpiryColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.bluewater:
        return Theme.of(context).primaryColorDark;

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

  static Color getEarlyBirdButtonColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.maxClub:
        return Theme.of(context).primaryColorDark;
      case Flavor.mannumClub:
        return const Color(0xff233250);

      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color getEarlyBirdDialogTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.maxClub:
        return AppColors.white;
      case Flavor.mannumClub:
        return const Color(0xff233250);

      default:
        return Theme.of(context).buttonTheme.colorScheme!.primary;
    }
  }

  static Color getNoLicenseTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mannumClub:
        return AppColors.mc_button_color;

      default:
        return Theme.of(context).textSelectionTheme.selectionColor!;
    }
  }

  static Color getChangeMobileTextColor(BuildContext context) {
    final Flavor selectedFlavor = FlavorConfig.instance.flavor!;

    switch (selectedFlavor) {
      case Flavor.mannumClub:
      case Flavor.bobsBulkBooze:
      case Flavor.senseOfTaste:
      case Flavor.drinkRewards:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }
}
