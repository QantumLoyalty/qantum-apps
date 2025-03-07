import 'dart:ui';

class AppColors {
  /// QANTUM THEME ///

  static Color get qa_back_color => const Color(0xFF002D72);

  static Color get qa_back_color_2 => const Color(0xFF070526);

  static Color get qa_text_color => const Color(0xFFffffff);

  static Color get qa_text_field_text_color => const Color(0xFF000000);

  static Color get qa_hint_text_color => const Color(0x63ffffff);

  static Color get qa_button_color => const Color(0xFF28ABE2);

  static Color get qa_button_color_2 => const Color(0xFF037ED5);

  static Color get qa_card_color => const Color(0x80FFFFFF);

  static Color get qa_divider_color => const Color(0xFFFFFFFF);


  /// MAX THEME ///

  static Color get max_back_color => const Color(0xFF541C65);

  static Color get max_back_color_2 => const Color(0xFF541C65);

  static Color get max_text_color => const Color(0xFFffffff);

  static Color get max_text_field_text_color => const Color(0xFF000000);

  static Color get max_hint_text_color => const Color(0xFFD9D9D9);

  static Color get max_button_color => const Color(0xFFCE132E);

  static Color get max_button_color_2 => const Color(0xFFCE132E);

  static Color get max_card_color => const Color(0xFFFFFFFF);

  static Color get max_divider_color => const Color(0xFFFFFFFF);



  /// STAR REWARD THEME ///

  static Color get sr_back_color => const Color(0xFF912325);

  static Color get sr_back_color_2 => const Color(0xFF912325);

  static Color get sr_text_color => const Color(0xFFd9bcbe);

  static Color get sr_text_field_text_color => const Color(0xFF000000);

  static Color get sr_hint_text_color => const Color(0xFF6D6D6D);

  static Color get sr_button_color => const Color(0xFF801f26);

  static Color get sr_card_color => const Color(0xFFFFFFFF);

  static Color get sr_divider_color => const Color(0xFF9d5555);

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
    switch ((membershipType ?? "").toLowerCase()) {
      case "valued":
        return const Color(0xFF14ad53);
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
