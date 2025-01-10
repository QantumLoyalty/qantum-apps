import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';

class AppThemes {
  static ThemeData get qantumTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.qa_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.qa_text_color,
        selectionColor: AppColors.qa_text_color,
        cursorColor: AppColors.qa_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.qa_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.qa_text_color,
              secondary: AppColors.qa_button_color_2,
              primary: AppColors.qa_button_color),
          buttonColor: AppColors.qa_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.qa_button_color,
          secondary: AppColors.qa_button_color,
          surface: AppColors.qa_button_color),
      primaryColor: AppColors.qa_back_color,
      primaryColorDark: AppColors.qa_back_color_2,
      cardColor: AppColors.qa_card_color,
      canvasColor: AppColors.qa_back_color,
      scaffoldBackgroundColor: Colors.transparent,
      dividerColor: AppColors.qa_divider_color,
      hintColor: AppColors.qa_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.qa_button_color),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.qa_hint_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.qa_text_color;
          }
          return AppColors.qa_hint_text_color;
        }),
      ),
      disabledColor: AppColors.white,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.qa_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.qa_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.qa_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.qa_hint_text_color;
          }
          return AppColors.qa_text_color;
        }),
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return Colors.transparent;
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData());

  static ThemeData get starRewardTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.sr_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.sr_text_color,
        selectionColor: AppColors.sr_text_color,
        cursorColor: AppColors.sr_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.sr_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.white, primary: AppColors.sr_button_color),
          buttonColor: AppColors.sr_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.sr_button_color,
          secondary: AppColors.sr_button_color,
          surface: AppColors.sr_button_color),
      primaryColor: AppColors.sr_back_color,
      primaryColorDark: AppColors.sr_back_color_2,
      cardColor: AppColors.sr_card_color,
      canvasColor: AppColors.sr_back_color,
      scaffoldBackgroundColor: AppColors.sr_back_color,
      dividerColor: AppColors.sr_divider_color,
      hintColor: AppColors.sr_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.sr_hint_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.sr_text_color;
          }
          return AppColors.sr_hint_text_color;
        }),
      ),
      disabledColor: AppColors.white,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.sr_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.sr_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.sr_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.sr_hint_text_color;
          }
          return AppColors.sr_text_color;
        }),
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return Colors.transparent;
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData());

  static ThemeData get sotTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.sot_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.sot_text_color,
        selectionColor: AppColors.sot_text_color,
        cursorColor: AppColors.sot_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.sot_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.white, primary: AppColors.sot_button_color),
          buttonColor: AppColors.sot_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.sot_button_color,
          secondary: AppColors.sot_button_color,
          surface: AppColors.sot_button_color),
      /* bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.oceanBlueThemeBottomNavigationBarColor),
    iconTheme: IconThemeData(color: AppColors.oceanBlueThemeBodyIconColor),
*/
      primaryColor: AppColors.sot_back_color,
      primaryColorDark: AppColors.sot_back_color_2,
      cardColor: AppColors.sot_card_color,
      canvasColor: AppColors.sot_back_color,
      scaffoldBackgroundColor: AppColors.sot_back_color,
      dividerColor: AppColors.sot_divider_color,
      hintColor: AppColors.sot_hint_text_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.sot_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.sot_divider_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.sot_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.sot_hint_text_color;
          }
          return AppColors.sot_text_color;
        }),
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return Colors.transparent;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.sot_hint_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.sot_text_color;
          }
          return AppColors.sot_hint_text_color;
        }),
      ),
      iconTheme: IconThemeData(color: AppColors.black)

      /*secondaryHeaderColor: AppColors.oceanBlueThemeTextTitleColor,
    unselectedWidgetColor: AppColors.oceanBlueThemeLeftDrawerColor,
    hintColor: AppColors.oceanBlueThemeTextHintColor,
    focusColor: AppColors.oceanBlueThemeSelectedBottomNavigationIconColor,
    disabledColor: AppColors.oceanBlueThemeButtonDisableColor,
    indicatorColor: AppColors.oceanBlueThemeBodyIconColor,
    highlightColor: AppColors.oceanBlueThemeAppTabBarIconsColor,
    primaryColorLight: AppColors.oceanBlueThemePrimaryLightColor,
    splashColor: AppColors.oceanBlueThemeGradientColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.oceanBlueThemeBottomNavigationBarColor,
      selectedItemColor: AppColors.oceanBlueThemeBodyIconColor,
      unselectedItemColor: AppColors.oceanBlueThemeBottomNavigationIconColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.oceanBlueThemeBottomNavigationBarColor,
      foregroundColor: AppColors.oceanBlueThemeBottomNavigationBarColor,
      iconTheme:
      IconThemeData(color: AppColors.oceanBlueThemeAppTabBarIconsColor),
      actionsIconTheme: const IconThemeData(
          color: AppColors.oceanBlueThemeAppTabBarIconsColor),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.oceanBlueThemeSmallCardColor;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor:
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.oceanBlueThemeSmallCardColor;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.oceanBlueThemeSmallCardColor;
        }
        return null;
      }),
      trackColor:
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.oceanBlueThemeSmallCardColor;
        }
        return null;
      }),
    ),*/
      );
}
