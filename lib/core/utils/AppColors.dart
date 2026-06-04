import 'package:flutter/material.dart';

import '../flavors_config/flavor_config.dart';

class AppColors {
  /// COMMON COLOR VALUES ///
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);
  static const Color _transparentButton = Color(0x00000000);
  static const Color _darkOverlay = Color(0x33000000);
  static const Color _hintWhite = Color(0x63FFFFFF);
  static const Color _softHintWhite = Color(0x61FFFFFF);
  static const Color _lightGrey = Color(0xFFD9D9D9);
  static const Color _disabledGrey = Color(0xFFF4F4F4);
  static const Color _whiteShadowColor = Color(0x80FFFFFF);
  static const Color _qantumSkyBlue = Color(0xFF28ABE2);
  static const Color _maxPurple = Color(0xFF541C65);
  static const Color _maxRed = Color(0xFFCE132E);
  static const Color _starRewardRed = Color(0xFFCD211F);
  static const Color _brandRed = Color(0xFFB11921);
  static const Color _darkHintGrey = Color(0xFF6D6D6D);
  static const Color _mhbcBlue = Color(0xFF233250);
  static const Color _mhbcLightBlue = Color(0xFFAEC1D9);
  static const Color _clhDark = Color(0xFF190000);
  static const Color _montaukTeal = Color(0xFF2984A3);
  static const Color _brightCyan = Color(0xFF55F6FF);
  static const Color _hogansBlue = Color(0xFF01ABE0);
  static const Color _senseDark = Color(0xFF24272A);
  static const Color _senseGold = Color(0xFFC79C6E);
  static const Color _northShoreGold = Color(0xFFC0A36B);
  static const Color _northShoreBlue = Color(0xFF2E3C53);
  static const Color _paleCanvasGrey = Color(0xFFCED2CE);
  static const Color _brisbaneLightBlue = Color(0xFFD6F4F9);
  static const Color _brisbaneBlue = Color(0xFF057CF4);
  static const Color _paleBlueDivider = Color(0xFFE2F7FB);
  static const Color _woollahraGreen = Color(0xFF364328);
  static const Color _blueWaterNavy = Color(0xFF213153);
  static const Color _flindersBlue = Color(0xFF5C82AB);
  static const Color _flindersBackground = Color(0xFFF2F0E7);
  static const Color _flindersPaleBlue = Color(0xFFB8C9CE);
  static const Color _kingscliffBlue = Color(0xFF34A5DF);
  static const Color _valuedGreen = Color(0xFF14AD53);
  static const Color _wonthaggiNavy = Color(0xFF222E5A);
  static const Color _edpGreen = Color(0xFF72B42F);
  static const Color _bobsOrange = Color(0xFFFF8F00);
  static const Color _bobsMaroon = Color(0xFF971B2F);
  static const Color _mosaicBlue = Color(0xFF08385B);
  static const Color _mosaicBackground = Color(0xFFFFF7E6);
  static const Color _mannumBlue = Color(0xFF00B0F0);
  static const Color _mannumDark = Color(0xFF2D3748);

  /// QANTUM THEME ///

  static Color get qa_primary_color => const Color(0xFF002D72);

  static Color get qa_primary_color_dark => const Color(0xFF070526);

  static Color get qa_floating_button_icon_color => _white;

  static Color get qa_back_color_3 => const Color(0x3429ABE2);

  static Color get qa_text_color => _white;

  static Color get qa_text_field_text_color => _black;

  static Color get qa_hint_text_color => _hintWhite;

  static Color get qa_button_color => _qantumSkyBlue;

  static Color get qa_button_color_2 => const Color(0xFF037ED5);

  static Color get qa_card_color => const Color(0x26FFFFFF);

  static Color get qa_divider_color => _white;

  static Color get qa_disable_color => _qantumSkyBlue;

  /// MAX THEME ///

  static Color get max_back_color => _maxPurple;

  static Color get max_back_color_2 => _maxPurple;

  static Color get max_floating_button_icon_color => _maxPurple;

  static Color get max_back_color_3 => _maxRed;

  static Color get max_text_color => _white;

  static Color get max_text_field_text_color => _black;

  static Color get max_hint_text_color => _lightGrey;

  static Color get max_button_color => _maxRed;

  static Color get max_button_color_2 => _maxRed;

  static Color get max_card_color => _white;

  static Color get max_divider_color => _white;

  static Color get max_disable_color => _maxPurple;

  /// STAR REWARD THEME ///

  static Color get sr_back_color_2 => _starRewardRed;

  static Color get sr_back_color => _brandRed;

  static Color get sr_floating_button_icon_color => _starRewardRed;

  static Color get sr_back_color_3 => _darkOverlay;

  static Color get sr_text_color => _white;

  static Color get sr_text_field_text_color => _black;

  static Color get sr_hint_text_color => _darkHintGrey;

  static Color get sr_button_color => _starRewardRed;

  static Color get sr_button_border_color => _white;

  static Color get sr_card_color => _white;

  static Color get sr_divider_color => _lightGrey;

  static Color get sr_disable_color => const Color(0xFF081427);

  /// MANLY HARBOUR BOAT CLUB THEME ///

  static Color get mhbc_sf_color => _mhbcLightBlue;

  static Color get mhbc_back_color_2 => _mhbcBlue;

  static Color get mhbc_floating_button_icon_color => _brandRed;

  static Color get mhbc_back_color => _mhbcBlue;

  static Color get mhbc_back_color_3 => _darkOverlay;

  static Color get mhbc_text_color => _white;

  static Color get mhbc_text_field_text_color => _black;

  static Color get mhbc_hint_text_color => _darkHintGrey;

  static Color get mhbc_button_color => _mhbcBlue;

  static Color get mhbc_button_border_color => _white;

  static Color get mhbc_card_color => _white;

  static Color get mhbc_divider_color => _lightGrey;

  //static Color get mhbc_disable_color => _mhbcLightBlue;
  static Color get mhbc_disable_color => _mhbcBlue;

  /// MANLY HARBOUR BOAT CLUB THEME ///

  static Color get clh_sf_color => const Color(0xFFD23434);

  static Color get clh_back_color_2 => _clhDark;

  static Color get clh_floating_button_icon_color => _brandRed;

  static Color get clh_back_color => _clhDark;

  static Color get clh_back_color_3 => _darkOverlay;

  static Color get clh_text_color => _white;

  static Color get clh_text_field_text_color => _black;

  static Color get clh_hint_text_color => _lightGrey;

  static Color get clh_button_color => _clhDark;

  static Color get clh_button_border_color => _white;

  static Color get clh_card_color => _white;

  static Color get clh_divider_color => _lightGrey;

  static Color get clh_disable_color => _clhDark;

  /// MONTAUK TAVERN ///

  static Color get mt_sf_color => _montaukTeal;

  static Color get mt_back_color => const Color(0xFF111A25);

  static Color get mt_floating_button_icon_color => _brandRed;

  static Color get mt_back_color_2 => _montaukTeal;

  static Color get mt_back_color_3 => _brightCyan;

  static Color get mt_text_color => _white;

  static Color get mt_text_field_text_color => _black;

  static Color get mt_hint_text_color => _lightGrey;

  static Color get mt_button_color => const Color(0x00FFFFFF);

  static Color get mt_button_border_color => _white;

  static Color get mt_card_color => _white;

  static Color get mt_divider_color => _lightGrey;

  static Color get mt_disable_color => _brightCyan;

  /// HOGANS REWARD THEME ///

  static Color get hr_sf_color => _black;

  static Color get hr_back_color => _black;

  static Color get hr_floating_button_icon_color => _brandRed;

  static Color get hr_back_color_2 => _black;

  static Color get hr_back_color_3 => _brightCyan;

  static Color get hr_text_color => _white;

  static Color get hr_text_field_text_color => _black;

  static Color get hr_hint_text_color => _lightGrey;

  static Color get hr_button_color => _hogansBlue;

  static Color get hr_button_border_color => _hogansBlue;

  static Color get hr_card_color => _white;

  static Color get hr_divider_color => _lightGrey;

  static Color get hr_disable_color => _hogansBlue;

  /// SENSE OF TASTE THEME ///

  static Color get sot_back_color => _senseDark;

  static Color get sot_back_color_2 => _senseDark;

  static Color get sot_text_color => _white;

  static Color get sot_text_field_text_color => _white;

  static Color get sot_hint_text_color => _softHintWhite;

  static Color get sot_button_color => _senseGold;

  static Color get sot_card_color => _black;

  static Color get sot_divider_color => _white;

  static Color get sot_scaffold_bg_color => _senseGold;

  static Color get sot_disabled_color => _senseGold;

  static Color get sot_floating_button_icon_color => _white;

  static Color get sot_profile_cross_background_color => _senseGold;

  /// NORTH SHORE TAVERN ///

  static Color get nst_sf_color => _northShoreGold;

  static Color get nst_back_color => _northShoreBlue;

  static Color get nst_floating_button_icon_color => _brandRed;

  static Color get nst_back_color_2 => _northShoreBlue;

  static Color get nst_back_color_3 => _brightCyan;

  static Color get nst_text_color => _white;

  static Color get nst_text_field_text_color => _black;

  static Color get nst_hint_text_color => _lightGrey;

  static Color get nst_button_color => _northShoreBlue;

  static Color get nst_button_border_color => _white;

  static Color get nst_card_color => _white;

  static Color get nst_divider_color => _northShoreBlue;

  static Color get nst_disable_color => _brightCyan;

  static Color get nst_canvas_color => _paleCanvasGrey;

  /// ACE REWARDS ///

  static Color get ar_sf_color => _northShoreGold;

  static Color get ar_back_color => const Color(0xFFBC965C);

  static Color get ar_floating_button_icon_color => _brandRed;

  static Color get ar_back_color_2 => _black;

  static Color get ar_back_color_3 => _brightCyan;

  static Color get ar_text_color => _white;

  static Color get ar_text_field_text_color => _black;

  static Color get ar_hint_text_color => _lightGrey;

  static Color get ar_button_color => _transparentButton;

  static Color get ar_button_border_color => _white;

  static Color get ar_card_color => _white;

  static Color get ar_divider_color => _northShoreBlue;

  static Color get ar_disable_color => _black;

  static Color get ar_canvas_color => _paleCanvasGrey;

  /// BRISBANE BREWING ///

  static Color get bb_sf_color => const Color(0xFF047CF4);

  static Color get bb_back_color => _brisbaneLightBlue;

  static Color get bb_floating_button_icon_color => _brandRed;

  static Color get bb_back_color_2 => _brisbaneLightBlue;

  static Color get bb_back_color_3 => _brisbaneLightBlue;

  static Color get bb_text_color => _brisbaneBlue;

  static Color get bb_text_field_text_color => _black;

  static Color get bb_hint_text_color => _lightGrey;

  static Color get bb_button_color => _brisbaneBlue;

  static Color get bb_button_border_color => _brisbaneBlue;

  static Color get bb_card_color => _white;

  static Color get bb_divider_color => _paleBlueDivider;

  static Color get bb_disable_color => _white;

  static Color get bb_canvas_color => const Color(0xFF002885);

  /// WOOLLAHRA HOTEL ///

  static Color get wh_sf_color => const Color(0xFF7B7424);

  static Color get wh_back_color => _woollahraGreen;

  static Color get wh_floating_button_icon_color => _brandRed;

  static Color get wh_back_color_2 => _woollahraGreen;

  static Color get wh_back_color_3 => _woollahraGreen;

  static Color get wh_text_color => _white;

  static Color get wh_text_field_text_color => _black;

  static Color get wh_hint_text_color => _lightGrey;

  static Color get wh_button_color => _transparentButton;

  static Color get wh_button_border_color => _white;

  static Color get wh_card_color => _white;

  static Color get wh_divider_color => _paleBlueDivider;

  static Color get wh_disable_color => _white;

  static Color get wh_canvas_color => const Color(0xFFE5CEAA);

  /// BLUE WATER ///

  static Color get bcc_sf_color => _blueWaterNavy;

  static Color get bcc_back_color => _blueWaterNavy;

  static Color get bcc_floating_button_icon_color => _brandRed;

  static Color get bcc_back_color_2 => _blueWaterNavy;

  static Color get bcc_back_color_3 => _blueWaterNavy;

  static Color get bcc_text_color => _white;

  static Color get bcc_text_field_text_color => _black;

  static Color get bcc_hint_text_color => _lightGrey;

  static Color get bcc_button_color => _transparentButton;

  static Color get bcc_button_border_color => _white;

  static Color get bcc_card_color => _white;

  static Color get bcc_divider_color => _northShoreBlue;

  static Color get bcc_disable_color => _disabledGrey;

  static Color get bcc_canvas_color => const Color(0xFF3F87C5);

  /// FLINDERS STREET WHARVES ///

  static Color get fw_sf_color => _flindersBlue;

  static Color get fw_back_color => _flindersBackground;

  static Color get fw_floating_button_icon_color => _brandRed;

  static Color get fw_back_color_2 => _flindersBackground;

  static Color get fw_back_color_3 => _flindersPaleBlue;

  static Color get fw_text_color => _flindersBlue;

  static Color get fw_text_field_text_color => _black;

  static Color get fw_hint_text_color => _lightGrey;

  static Color get fw_button_color => _transparentButton;

  static Color get fw_button_border_color => _flindersBlue;

  static Color get fw_card_color => _white;

  static Color get fw_divider_color => _lightGrey;

  static Color get fw_disable_color => _disabledGrey;

  static Color get fw_canvas_color => const Color(0xFFb7c9ce);

  /// KingsCliff Color///

  static Color get kc_primary_color => _kingscliffBlue;

  static Color get kc_primary_color_dark => const Color(0xFF375E93);

  static Color get kc_button_color => _kingscliffBlue;

  static Color get kc_button_border_color => _white;

  static Color get kc_divider_color => const Color(0xFF34A5DE);

  static Color get kc_hint_text_color => _hintWhite;

  static Color get kc_card_color => _white;

  static Color get kc_scaffold_bg_color => const Color(0xFF1D345B);

  static Color get kc_disabled_color => const Color(0xFF33A4DE);

  static Color get kc_text_color => _white;

  static Color get kc_floating_button_icon_color => _brandRed;

  static Color get kc_profile_cross_background_color => const Color(0xFF375F94);

  /// DrinkRewards Theme
  static Color get dr_primary_color => const Color(0xFF6c0471);

  static Color get dr_primary_color_dark => const Color(0xFF400244);

  static Color get dr_divider_color => _white;

  static Color get dr_button_color => const Color(0xFFB044B4);

  static Color get dr_text_color => _white;

  static Color get dr_text_field_text_color => _black;

  static Color get dr_hint_text_color => _hintWhite;

  static Color get dr_canvas_color => const Color(0xFF3D0240);

  static Color get dr_account_header_color => const Color(0xFF18062e);

  static Color get dr_box_shadow => _whiteShadowColor;

  /// WONTHAGGI THEME
  static Color get wt_sf_color => _wonthaggiNavy;

  static Color get wt_back_color => const Color(0xFFF7F1E2);

  static Color get wt_floating_button_icon_color => _wonthaggiNavy;

  static Color get wt_back_color_2 => _flindersBackground;

  static Color get wt_back_color_3 => _flindersPaleBlue;

  static Color get wt_text_color => _wonthaggiNavy;

  static Color get wt_text_field_text_color => _black;

  static Color get wt_hint_text_color => const Color(0x66222E5A);

  static Color get wt_button_color => _wonthaggiNavy;

  static Color get wt_button_border_color => _wonthaggiNavy;

  static Color get wt_card_color => _white;

  static Color get wt_divider_color => _lightGrey;

  static Color get wt_disable_color => _disabledGrey;

  static Color get wt_canvas_color => _wonthaggiNavy;

  /// EDP COLOR

  static Color get edp_sf_color => _black;

  static Color get edp_back_color => _black;

  static Color get edp_floating_button_icon_color => _white;

  static Color get edp_back_color_2 => _black;

  static Color get edp_text_color => _white;

  static Color get edp_text_field_text_color => _white;

  static Color get edp_hint_text_color => const Color(0x39FFFFFF);

  static Color get edp_button_color => _edpGreen;

  static Color get edp_button_border_color => _edpGreen;

  static Color get edp_card_color => _white;

  static Color get edp_divider_color => _whiteShadowColor;

  static Color get edp_disable_color => _disabledGrey;

  static Color get edp_canvas_color => const Color(0xFF285FA9);

  static Color get edp_textformField_background_color =>
      const Color(0xFF707070);

  /// Bobs bulk booze color

  static Color get bob_back_color => _bobsOrange;

  static Color get bob_back_color_2 => _bobsOrange;

  static Color get bob_text_color => _white;

  static Color get bob_text_field_text_color => _white;

  static Color get bob_hint_text_color => _softHintWhite;

  static Color get bob_button_color => _bobsMaroon;

  static Color get bob_card_color => _bobsMaroon;

  static Color get bob_divider_color => _white;

  static Color get bob_scaffold_bg_color => _bobsMaroon;

  static Color get bob_disabled_color => const Color(0xFF49141D);

  static Color get bob_floating_button_icon_color => _white;

  static Color get bob_profile_cross_background_color => _white;

  /// Mosaic Hotel

  static Color get mh_sf_color => _mosaicBlue;

  static Color get mh_back_color => _mosaicBackground;

  static Color get mh_floating_button_icon_color => _brandRed;

  static Color get mh_back_color_2 => _mosaicBackground;

  static Color get mh_back_color_3 => _mosaicBackground;

  static Color get mh_text_color => _mosaicBlue;

  static Color get mh_text_field_text_color => _mosaicBlue;

  static Color get mh_hint_text_color => _lightGrey;

  static Color get mh_button_color => _mosaicBlue;

  static Color get mh_button_border_color => _mosaicBlue;

  static Color get mh_card_color => _white;

  static Color get mh_divider_color => _lightGrey;

  static Color get mh_disabled_color => _white;

  static Color get mh_canvas_color => _mosaicBlue;

  /// Mannum Club

  static Color get mc_sf_color => _mannumBlue;

  static Color get mc_back_color => _mannumDark;

  static Color get mc_floating_button_icon_color => _white;

  static Color get mc_back_color_2 => _mannumDark;

  static Color get mc_back_color_3 => _mannumDark;

  static Color get mc_text_color => _white;

  static Color get mc_text_field_text_color => _white;

  static Color get mc_hint_text_color => const Color(0x73FFFFFF);

  static Color get mc_button_color => _mannumBlue;

  static Color get mc_button_border_color => _mannumBlue;

  static Color get mc_card_color => _white;

  static Color get mc_divider_color => _paleBlueDivider;

  static Color get mc_disable_color => _white;

  static Color get mc_canvas_color => _mannumBlue;

  /// COMMON COLORS ///
  static Color get white => _white;

  static Color get black => _black;

  static Color get blue => const Color(0xFF007ac7);

  static Color get sky_blue => const Color(0xFF86cdf1);

  static Color get dark_blue => const Color(0xFF000814);

  static Color get success_green => const Color(0xFF19A204);

  static Color get error_red => const Color(0xFFFF0303);

  static Color get shadow => const Color(0xA6000000);

  static Color get bright_sky_blue => _qantumSkyBlue;

  static Color get disable_color => const Color(0xFFC0C0C0);

  static Color get white_shadow => _whiteShadowColor;

  static Color get button_shadow => const Color(0x2EFFFFFF);

  static Color get white_opacity => const Color(0x27FFFFFF);

  static Color get transparent => Colors.transparent;

  static Color getMembershipCategoryColor(String? membershipType) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch ((membershipType ?? "").toLowerCase()) {
      case "valued":
        {
          switch (selectedFlavor) {
            case Flavor.qantum || Flavor.qantumClub:
              return _valuedGreen;
            case Flavor.maxx || Flavor.maxClub:
              return const Color(0xFFdb023d);
            case Flavor.starReward:
              return const Color(0xFFc72224);
            default:
              return _valuedGreen;
          }
        }

      case "silver":
        return const Color(0xFFb8b8b8);
      case "gold":
        return const Color(0xFFd6b25b);
      case "platinum":
        return const Color(0xFF898b8e);
      case "platinumblack":
        return const Color(0xFF2f2f2f);
      default:
        return _valuedGreen;
    }
  }
}
