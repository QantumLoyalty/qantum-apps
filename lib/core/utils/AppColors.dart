import 'dart:ui';

import '../flavors_config/flavor_config.dart';

class AppColors {
  /// QANTUM THEME ///

  static Color get qa_back_color => const Color(0xFF002D72);

  static Color get qa_back_color_2 => const Color(0xFF070526);

  static Color get qa_floating_button_icon_color => const Color(0xFFFFFFFF);

  static Color get qa_back_color_3 => const Color(0x3429ABE2);

  static Color get qa_text_color => const Color(0xFFffffff);

  static Color get qa_text_field_text_color => const Color(0xFF000000);

  static Color get qa_hint_text_color => const Color(0x63ffffff);

  static Color get qa_button_color => const Color(0xFF28ABE2);

  static Color get qa_button_color_2 => const Color(0xFF037ED5);

  static Color get qa_card_color => const Color(0x26FFFFFF);

  static Color get qa_divider_color => const Color(0xFFFFFFFF);

  static Color get qa_disable_color => const Color(0xFF28ABE2);

  /// MAX THEME ///

  static Color get max_back_color => const Color(0xFF541C65);

  static Color get max_back_color_2 => const Color(0xFF541C65);

  static Color get max_floating_button_icon_color => const Color(0xFF541C65);

  static Color get max_back_color_3 => const Color(0xFFCE132E);

  static Color get max_text_color => const Color(0xFFffffff);

  static Color get max_text_field_text_color => const Color(0xFF000000);

  static Color get max_hint_text_color => const Color(0xFFD9D9D9);

  static Color get max_button_color => const Color(0xFFCE132E);

  static Color get max_button_color_2 => const Color(0xFFCE132E);

  static Color get max_card_color => const Color(0xFFFFFFFF);

  static Color get max_divider_color => const Color(0xFFFFFFFF);

  static Color get max_disable_color => const Color(0xFF541C65);

  /// STAR REWARD THEME ///

  static Color get sr_back_color_2 => const Color(0xFFCD211F);

  static Color get sr_back_color => const Color(0xFFB11921);

  static Color get sr_floating_button_icon_color => const Color(0xFFCD211F);

  static Color get sr_back_color_3 => const Color(0x33000000);

  static Color get sr_text_color => const Color(0xFFFFFFFF);

  static Color get sr_text_field_text_color => const Color(0xFF000000);

  static Color get sr_hint_text_color => const Color(0xFF6D6D6D);

  static Color get sr_button_color => const Color(0xFFCD211F);

  static Color get sr_button_border_color => const Color(0xFFFFFFFF);

  static Color get sr_card_color => const Color(0xFFFFFFFF);

  static Color get sr_divider_color => const Color(0xFF9d5555);

  static Color get sr_disable_color => const Color(0xFF081427);

  /// MANLY HARBOUR BOAT CLUB THEME ///

  static Color get mhbc_sf_color => const Color(0xFFAEC1D9);

  static Color get mhbc_back_color_2 => const Color(0xFF233250);

  static Color get mhbc_floating_button_icon_color => const Color(0xFFB11921);

  static Color get mhbc_back_color => const Color(0xFF233250);

  static Color get mhbc_back_color_3 => const Color(0x33000000);

  static Color get mhbc_text_color => const Color(0xFFFFFFFF);

  static Color get mhbc_text_field_text_color => const Color(0xFF000000);

  static Color get mhbc_hint_text_color => const Color(0xFF6D6D6D);

  static Color get mhbc_button_color => const Color(0xFF233250);

  static Color get mhbc_button_border_color => const Color(0xFFFFFFFF);

  static Color get mhbc_card_color => const Color(0xFFFFFFFF);

  static Color get mhbc_divider_color => const Color(0xFFD9D9D9);

  static Color get mhbc_disable_color => const Color(0xFFAEC1D9);

  /// SENSE OF TASTE THEME ///

  static Color get sot_back_color => const Color(0xFFc69c6e);

  static Color get sot_back_color_2 => const Color(0xFFc69c6e);

  static Color get sot_text_color => const Color(0xFF4e4e4e);

  static Color get sot_text_field_text_color => const Color(0xFFd4b491);

  static Color get sot_hint_text_color => const Color(0xFF6D6D6D);

  static Color get sot_button_color => const Color(0xFF4e4e4e);

  static Color get sot_card_color => const Color(0xFF444444);

  static Color get sot_divider_color => const Color(0xFFd4b491);

  /// COMMON COLORS ///
  static Color get white => const Color(0xFFFFFFFF);

  static Color get black => const Color(0xFF000000);

  static Color get blue => const Color(0xFF007ac7);

  static Color get sky_blue => const Color(0xFF86cdf1);

  static Color get dark_blue => const Color(0xFF000814);

  static Color get success_green => const Color(0xFF19A204);

  static Color get error_red => const Color(0xFFFF0303);

  static Color get shadow => const Color(0xA6000000);

  static Color get bright_sky_blue => const Color(0xFF28ABE2);

  static Color getMembershipCategoryColor(String? membershipType) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch ((membershipType ?? "").toLowerCase()) {
      case "valued":
        {
          switch (selectedFlavor) {
            case Flavor.qantum:
              return const Color(0xFF14ad53);
            case Flavor.maxx:
              return const Color(0xFFdb023d);
            case Flavor.starReward:
              return const Color(0xFFc72224);
            default:
              return const Color(0xFF14ad53);
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
        return const Color(0xFF14ad53);
    }
  }
}
