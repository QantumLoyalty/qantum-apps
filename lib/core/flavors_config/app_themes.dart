import 'package:flutter/material.dart';

import '../utils/AppColors.dart';

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
              onPrimary: AppColors.white,
              secondary: AppColors.qa_button_color_2,
              onSecondary: AppColors.qa_button_color,
              primary: AppColors.qa_button_color),
          buttonColor: AppColors.qa_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.qa_button_color,
          secondary: AppColors.qa_button_color,
          surface: AppColors.qa_button_color),
      primaryColor: AppColors.qa_back_color,
      primaryColorDark: AppColors.qa_back_color_2,
      cardColor: AppColors.qa_card_color,
      canvasColor: AppColors.qa_back_color_3,
      scaffoldBackgroundColor: AppColors.qa_back_color_2,
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
      disabledColor: AppColors.qa_button_color,
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
      progressIndicatorTheme: ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.qa_button_color,
          foregroundColor: AppColors.qa_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.qa_button_color
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.qa_back_color_2)));

  static ThemeData get maxTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.max_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.max_text_field_text_color,
        selectionColor: AppColors.max_text_color,
        cursorColor: AppColors.max_button_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.max_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.max_text_color,
              onSecondary: AppColors.max_button_color,
              secondary: AppColors.max_button_color_2,
              primary: AppColors.max_button_color),
          buttonColor: AppColors.max_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.max_button_color,
          secondary: AppColors.white,
          surface: AppColors.max_button_color),
      primaryColor: AppColors.max_back_color,
      primaryColorDark: AppColors.max_back_color_2,
      cardColor: AppColors.max_card_color,
      canvasColor: AppColors.max_button_color,
      scaffoldBackgroundColor: AppColors.max_back_color_3,
      dividerColor: AppColors.max_divider_color,
      hintColor: AppColors.max_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.max_divider_color),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.max_hint_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.max_text_color;
          }
          return AppColors.max_hint_text_color;
        }),
      ),
      disabledColor: AppColors.max_back_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.max_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.max_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.max_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.max_hint_text_color;
          }
          return AppColors.max_text_color;
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
      progressIndicatorTheme: ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.max_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.max_back_color
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.max_back_color)));

  static ThemeData get starRewardTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.sr_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.sr_text_field_text_color,
        selectionColor: AppColors.sr_text_color,
        cursorColor: AppColors.sr_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.sr_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.max_text_color,
              onSecondary: AppColors.sr_button_border_color,
              secondary: AppColors.sr_back_color,
              primary: AppColors.sr_button_color),
          buttonColor: AppColors.sr_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.sr_button_color,
          secondary: AppColors.white,
          surface: AppColors.sr_button_color),
      primaryColorDark: AppColors.sr_back_color_2,
      primaryColor: AppColors.sr_back_color,
      cardColor: AppColors.sr_card_color,
      canvasColor: AppColors.black.withValues(alpha: 0.15),
      scaffoldBackgroundColor: AppColors.sr_back_color_2,
      dividerColor: AppColors.sr_divider_color,
      hintColor: AppColors.sr_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.sr_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.sr_disable_color,
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
      progressIndicatorTheme: ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.sr_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.sr_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.sr_back_color_2)));

  static ThemeData get mhbcTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.mhbc_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.mhbc_text_field_text_color,
        selectionColor: AppColors.mhbc_text_color,
        cursorColor: AppColors.mhbc_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.mhbc_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.mhbc_text_color,
              onSecondary: AppColors.mhbc_button_border_color,
              secondary: AppColors.mhbc_back_color,
              primary: AppColors.mhbc_button_color),
          buttonColor: AppColors.mhbc_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.mhbc_button_color,
          secondary: AppColors.white,
          surface: AppColors.mhbc_button_color),
      primaryColorDark: AppColors.mhbc_back_color_2,
      primaryColor: AppColors.mhbc_back_color,
      cardColor: AppColors.mhbc_card_color,
      canvasColor: AppColors.mhbc_back_color,
      scaffoldBackgroundColor: AppColors.mhbc_sf_color,
      dividerColor: AppColors.mhbc_divider_color,
      hintColor: AppColors.mhbc_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.mhbc_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.mhbc_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.mhbc_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.mhbc_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.mhbc_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.mhbc_hint_text_color;
          }
          return AppColors.mhbc_text_color;
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
      progressIndicatorTheme: ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.mhbc_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.mhbc_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.mhbc_back_color_2)));

  static ThemeData get clhTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.clh_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.clh_text_field_text_color,
        selectionColor: AppColors.clh_text_color,
        cursorColor: AppColors.clh_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.clh_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.clh_text_color,
              onSecondary: AppColors.clh_button_border_color,
              secondary: AppColors.clh_back_color,
              primary: AppColors.clh_button_color),
          buttonColor: AppColors.clh_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.clh_button_color,
          secondary: AppColors.white,
          surface: AppColors.clh_button_color),
      primaryColorDark: AppColors.clh_back_color_2,
      primaryColor: AppColors.clh_back_color,
      cardColor: AppColors.clh_card_color,
      canvasColor: AppColors.clh_sf_color,
      scaffoldBackgroundColor: AppColors.clh_sf_color,
      dividerColor: AppColors.clh_divider_color,
      hintColor: AppColors.clh_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.clh_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.clh_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.clh_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.clh_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.clh_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.clh_hint_text_color;
          }
          return AppColors.clh_text_color;
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
      progressIndicatorTheme: ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.clh_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.clh_sf_color
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.clh_sf_color)));

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
