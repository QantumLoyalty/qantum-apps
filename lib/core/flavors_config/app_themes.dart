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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.qa_back_color),
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.max_back_color),
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.sr_back_color),
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.mhbc_back_color),
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.clh_back_color),
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

  static ThemeData get montaukTavernTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.mt_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.mt_text_field_text_color,
        selectionColor: AppColors.mt_text_color,
        cursorColor: AppColors.mt_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.mt_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.mt_text_color,
              onSecondary: AppColors.mt_button_border_color,
              secondary: AppColors.mt_back_color,
              primary: AppColors.mt_button_color),
          buttonColor: AppColors.mt_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.mt_button_color,
          secondary: AppColors.white,
          surface: AppColors.mt_button_color),
      primaryColorDark: AppColors.mt_back_color_2,
      primaryColor: AppColors.mt_back_color,
      cardColor: AppColors.mt_card_color,
      canvasColor: AppColors.mt_back_color_2,
      scaffoldBackgroundColor: AppColors.mt_sf_color,
      dividerColor: AppColors.mt_divider_color,
      hintColor: AppColors.mt_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.mt_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.mt_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.mt_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.mt_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.mt_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.mt_hint_text_color;
          }
          return AppColors.mt_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.mt_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.mt_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.mt_sf_color
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.mt_sf_color)));

  static ThemeData get aceRewardsTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.ar_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.ar_text_field_text_color,
        selectionColor: AppColors.ar_text_color,
        cursorColor: AppColors.ar_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.ar_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.ar_text_color,
              onSecondary: AppColors.ar_button_border_color,
              secondary: AppColors.ar_back_color,
              primary: AppColors.ar_button_color),
          buttonColor: AppColors.ar_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.ar_button_color,
          secondary: AppColors.white,
          surface: AppColors.ar_button_color),
      primaryColorDark: AppColors.ar_back_color_2,
      primaryColor: AppColors.ar_back_color,
      cardColor: AppColors.ar_card_color,
      canvasColor: AppColors.ar_back_color,
      scaffoldBackgroundColor: AppColors.ar_sf_color,
      dividerColor: AppColors.ar_divider_color,
      hintColor: AppColors.ar_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.ar_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.ar_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.ar_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.ar_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.ar_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.ar_hint_text_color;
          }
          return AppColors.ar_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.ar_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.ar_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.ar_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.ar_back_color_2)));

  static ThemeData get bluewaterTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.bcc_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.bcc_text_field_text_color,
        selectionColor: AppColors.bcc_text_color,
        cursorColor: AppColors.bcc_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.bcc_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.bcc_text_color,
              onSecondary: AppColors.bcc_button_border_color,
              secondary: AppColors.bcc_back_color,
              primary: AppColors.bcc_button_color),
          buttonColor: AppColors.bcc_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.bcc_button_color,
          secondary: AppColors.white,
          surface: AppColors.bcc_button_color),
      primaryColorDark: AppColors.bcc_back_color_2,
      primaryColor: AppColors.bcc_back_color,
      cardColor: AppColors.bcc_card_color,
      canvasColor: AppColors.bcc_canvas_color,
      scaffoldBackgroundColor: AppColors.bcc_sf_color,
      dividerColor: AppColors.bcc_divider_color,
      hintColor: AppColors.bcc_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.bcc_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.bcc_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.bcc_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.bcc_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.bcc_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.bcc_hint_text_color;
          }
          return AppColors.bcc_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.bcc_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.bcc_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.bcc_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.bcc_floating_button_icon_color)));

  static ThemeData get hogansTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.hr_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.hr_text_field_text_color,
        selectionColor: AppColors.hr_text_color,
        cursorColor: AppColors.hr_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.hr_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.hr_text_color,
              onSecondary: AppColors.white,
              secondary: AppColors.hr_back_color,
              primary: AppColors.hr_button_color),
          buttonColor: AppColors.hr_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.hr_button_color,
          secondary: AppColors.white,
          surface: AppColors.hr_button_color),
      primaryColorDark: AppColors.hr_back_color_2,
      primaryColor: AppColors.hr_back_color,
      cardColor: AppColors.hr_card_color,
      canvasColor: AppColors.hr_button_color,
      scaffoldBackgroundColor: AppColors.hr_sf_color,
      dividerColor: AppColors.hr_divider_color,
      hintColor: AppColors.hr_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.hr_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.hr_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.hr_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.hr_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.hr_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.hr_hint_text_color;
          }
          return AppColors.hr_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.hr_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.hr_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.hr_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.hr_back_color_2)));

  static ThemeData get northShoreTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.nst_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.nst_text_field_text_color,
        selectionColor: AppColors.nst_text_color,
        cursorColor: AppColors.nst_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.nst_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.nst_text_color,
              onSecondary: AppColors.nst_button_border_color,
              secondary: AppColors.nst_back_color,
              primary: AppColors.nst_button_color),
          buttonColor: AppColors.nst_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.nst_button_color,
          secondary: AppColors.white,
          surface: AppColors.nst_button_color),
      primaryColorDark: AppColors.nst_back_color_2,
      primaryColor: AppColors.nst_back_color,
      cardColor: AppColors.nst_card_color,
      canvasColor: AppColors.nst_canvas_color,
      scaffoldBackgroundColor: AppColors.nst_sf_color,
      dividerColor: AppColors.nst_divider_color,
      hintColor: AppColors.nst_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.nst_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.nst_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.nst_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.nst_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.nst_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.nst_hint_text_color;
          }
          return AppColors.nst_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.nst_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.nst_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.nst_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.nst_back_color_2)));

  static ThemeData get queensTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.qh_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.qh_text_field_text_color,
        selectionColor: AppColors.qh_text_color,
        cursorColor: AppColors.qh_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.qh_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.qh_text_color,
              onSecondary: AppColors.qh_button_border_color,
              secondary: AppColors.qh_back_color,
              primary: AppColors.qh_button_color),
          buttonColor: AppColors.qh_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.qh_button_color,
          secondary: AppColors.white,
          surface: AppColors.qh_button_color),
      primaryColorDark: AppColors.qh_back_color_2,
      primaryColor: AppColors.qh_back_color,
      cardColor: AppColors.qh_card_color,
      canvasColor: AppColors.qh_canvas_color,
      scaffoldBackgroundColor: AppColors.qh_sf_color,
      dividerColor: AppColors.qh_divider_color,
      hintColor: AppColors.qh_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.qh_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.qh_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.qh_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.qh_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.qh_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.qh_hint_text_color;
          }
          return AppColors.qh_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.qh_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.qh_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.qh_back_color_2
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.qh_back_color_2)));

  static ThemeData get brisbaneTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.bb_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.bb_text_field_text_color,
        selectionColor: AppColors.bb_text_color,
        cursorColor: AppColors.bb_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.bb_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.bb_text_color,
              onSecondary: AppColors.bb_button_border_color,
              secondary: AppColors.bb_back_color,
              primary: AppColors.bb_button_color),
          buttonColor: AppColors.bb_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.bb_button_color,
          secondary: AppColors.white,
          surface: AppColors.bb_button_color),
      primaryColorDark: AppColors.bb_back_color_2,
      primaryColor: AppColors.bb_back_color,
      cardColor: AppColors.bb_card_color,
      canvasColor: AppColors.bb_canvas_color,
      scaffoldBackgroundColor: AppColors.bb_sf_color,
      dividerColor: AppColors.bb_divider_color,
      hintColor: AppColors.bb_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.bb_button_color),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.bb_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.bb_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.bb_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.bb_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.bb_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.bb_hint_text_color;
          }
          return AppColors.bb_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.bb_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.bb_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.bb_button_color
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.bb_button_color)));

  static ThemeData get woollahraTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.wh_back_color),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.wh_text_field_text_color,
        selectionColor: AppColors.wh_text_color,
        cursorColor: AppColors.wh_text_field_text_color,
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.wh_text_field_text_color)),
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              onPrimary: AppColors.wh_text_color,
              onSecondary: AppColors.wh_button_border_color,
              secondary: AppColors.wh_back_color,
              primary: AppColors.wh_button_color),
          buttonColor: AppColors.wh_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.wh_button_color,
          secondary: AppColors.white,
          surface: AppColors.wh_button_color),
      primaryColorDark: AppColors.wh_back_color_2,
      primaryColor: AppColors.wh_back_color,
      cardColor: AppColors.wh_card_color,
      canvasColor: AppColors.wh_canvas_color,
      scaffoldBackgroundColor: AppColors.wh_sf_color,
      dividerColor: AppColors.wh_divider_color,
      hintColor: AppColors.wh_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.white),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.wh_text_color;
          }
          return AppColors.white;
        }),
      ),
      disabledColor: AppColors.wh_disable_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.wh_back_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.wh_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.wh_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.wh_hint_text_color;
          }
          return AppColors.wh_text_color;
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
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.wh_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.wh_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.wh_back_color
                  : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
              state.contains(MaterialState.selected)
                  ? AppColors.white
                  : AppColors.wh_back_color)));

  static ThemeData get flindersTheme => ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: AppColors.fw_back_color),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColors.fw_text_field_text_color,
          selectionColor: AppColors.fw_text_color,
          cursorColor: AppColors.fw_text_field_text_color,
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(color: AppColors.fw_text_field_text_color)),
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent,
            colorScheme: ColorScheme.fromSwatch().copyWith(
                onPrimary: AppColors.fw_text_color,
                onSecondary: AppColors.fw_button_border_color,
                secondary: AppColors.fw_back_color,
                primary: AppColors.fw_button_color),
            buttonColor: AppColors.fw_button_color),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.fw_button_color,
            secondary: AppColors.white,
            surface: AppColors.fw_button_color),
        primaryColorDark: AppColors.fw_back_color_2,
        primaryColor: AppColors.fw_back_color,
        cardColor: AppColors.fw_card_color,
        canvasColor: AppColors.fw_canvas_color,
        scaffoldBackgroundColor: AppColors.fw_sf_color,
        dividerColor: AppColors.fw_divider_color,
        hintColor: AppColors.fw_hint_text_color,
        iconTheme: IconThemeData(color: AppColors.fw_button_border_color),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.fw_text_color;
            }
            if (states.contains(WidgetState.selected)) {
              return AppColors.fw_text_color;
            }
            return AppColors.fw_text_color;
          }),
        ),
        disabledColor: AppColors.fw_disable_color,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.fw_back_color),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.fw_text_color),
        checkboxTheme: CheckboxThemeData(
          checkColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.fw_text_color;
            }
            if (states.contains(WidgetState.selected)) {
              return AppColors.fw_hint_text_color;
            }
            return AppColors.fw_text_color;
          }),
          fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.transparent;
            }
            if (states.contains(WidgetState.selected)) {
              return AppColors.white;
            }
            return Colors.transparent;
          }),
        ),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: AppColors.fw_button_border_color),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.fw_floating_button_icon_color),
        switchTheme: SwitchThemeData(
            trackColor: MaterialStateProperty.resolveWith((state) =>
                state.contains(MaterialState.selected)
                    ? AppColors.fw_button_border_color
                    : AppColors.white),
            thumbColor: MaterialStateProperty.resolveWith((state) =>
                state.contains(MaterialState.selected)
                    ? AppColors.white
                    : AppColors.fw_button_border_color)),

  );

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

  static ThemeData get kingscliffTheme => ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.kc_primary_color),
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
              onSecondary: AppColors.kc_button_border_color,
              secondary: AppColors.kc_button_color,
              primary: AppColors.transparent),
          buttonColor: AppColors.kc_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.white,
          secondary: AppColors.white,
          surface: AppColors.white),
      primaryColorDark: AppColors.kc_primary_color,
      primaryColor: AppColors.kc_primary_color_dark,
      cardColor: AppColors.kc_card_color,
      canvasColor: AppColors.kc_scaffold_bg_color,
      scaffoldBackgroundColor: AppColors.kc_scaffold_bg_color,
      dividerColor: AppColors.kc_divider_color,
      hintColor: AppColors.kc_hint_text_color,
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
      disabledColor: AppColors.kc_disabled_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.kc_primary_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.kc_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
        WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.kc_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.kc_hint_text_color;
          }
          return AppColors.kc_text_color;
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
      progressIndicatorTheme:
      ProgressIndicatorThemeData(color: AppColors.kc_primary_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.kc_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
          state.contains(MaterialState.selected)
              ? AppColors.kc_divider_color
              : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
          state.contains(MaterialState.selected)
              ? AppColors.white
              : AppColors.kc_divider_color)));


  static ThemeData get drinkRewardTheme => ThemeData(
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
              secondary: AppColors.dr_button_color,
              onSecondary: AppColors.dr_button_color,
              primary: AppColors.dr_button_color),
          buttonColor: AppColors.dr_button_color),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.dr_button_color,
          secondary: AppColors.dr_button_color,
          surface: AppColors.dr_button_color),
      primaryColor: AppColors.dr_primary_color_dark,
      primaryColorDark: AppColors.dr_primary_color,
      cardColor: AppColors.qa_card_color,
      canvasColor: AppColors.dr_canvas_color,
      scaffoldBackgroundColor: AppColors.dr_account_header_color,
      dividerColor: AppColors.dr_divider_color,
      hintColor: AppColors.dr_hint_text_color,
      iconTheme: IconThemeData(color: AppColors.dr_button_color),
      radioTheme: RadioThemeData(
        fillColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.dr_hint_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.dr_text_color;
          }
          return AppColors.dr_hint_text_color;
        }),
      ),
      disabledColor: AppColors.dr_button_color,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.dr_account_header_color),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.dr_text_color),
      checkboxTheme: CheckboxThemeData(
        checkColor:
        WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.dr_text_color;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.dr_hint_text_color;
          }
          return AppColors.dr_text_color;
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
      progressIndicatorTheme:
      ProgressIndicatorThemeData(color: AppColors.qa_back_color),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.dr_button_color,
          foregroundColor: AppColors.qa_floating_button_icon_color),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith((state) =>
          state.contains(MaterialState.selected)
              ? AppColors.dr_button_color
              : AppColors.white),
          thumbColor: MaterialStateProperty.resolveWith((state) =>
          state.contains(MaterialState.selected)
              ? AppColors.white
              : AppColors.dr_button_color)));
}
