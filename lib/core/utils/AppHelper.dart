import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';

class AppHelper {
  static printMessage(String printableItem) {
    if (kDebugMode) {
      print(printableItem);
    }
  }

  static bool verifyPhoneNumber(String phoneNo) {
    if (phoneNo.isNotEmpty &&
        phoneNo.length == 10 ) {
      return true;
    }

    return false;
  }

  static bool verifyEmailAddress(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
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
}
