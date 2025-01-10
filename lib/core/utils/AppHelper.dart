import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';

class AppHelper {
  static printMessage(dynamic printableItem) {
    if (kDebugMode) {
      print(printableItem);
    }
  }

  static bool verifyPhoneNumber(String phoneNo) {
    if (phoneNo.isNotEmpty && phoneNo.length == 10) {
      return true;
    }

    return false;
  }

  static bool verifyEmailAddress(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static double getFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double baseScreenWidth = 375.0; // Standard screen width
    double scaleFactor = screenWidth / baseScreenWidth;
    return baseFontSize * scaleFactor;
  }

  static String formatDate(String? date) {
    String formattedDate = "";
    if (date != null && date.isNotEmpty) {
      try {
        DateTime inputDate = DateFormat("yyyy-MM-ddThh:mm:ss.000Z").parse(date);
        formattedDate = DateFormat("dd MMM, yyyy").format(inputDate);
      } catch (e) {
        AppHelper.printMessage(e.toString());
      }
    }

    return formattedDate;
  }

  static showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.success_green,
    ));
  }

  static showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: TextStyle(
            color: AppColors.white,
          )),
      backgroundColor: AppColors.error_red,
    ));
  }

  static BoxDecoration appBackground(BuildContext context) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Theme.of(context).primaryColorDark,
          Theme.of(context).primaryColor,
        ]));
  }

  static String maskPhoneNumber(String phone) {
    return "*******${phone.substring(phone.length - 3, phone.length)}";
  }

  static String maskEmail(String? email) {
    if (email != null && email.isNotEmpty) {
      String maskedEmail = email;
      if (email.contains("@")) {
        List<String> emailParts = email.split("@");
        AppHelper.printMessage(emailParts);
        if (emailParts.isNotEmpty) {
          String firstPart =
              "${emailParts[0].replaceRange(1, emailParts[0].length, "*" * (emailParts[0].length))}@";
          maskedEmail = firstPart;

          if (emailParts.length > 1) {
            String secondPart = emailParts[1].replaceRange(
                1, emailParts[1].length, "*" * (emailParts[1].length));
            maskedEmail = maskedEmail + secondPart;
          }
        }
      }
      return maskedEmail;
    } else {
      return "";
    }
  }
}
