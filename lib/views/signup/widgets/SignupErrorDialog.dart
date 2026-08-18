import 'package:flutter/material.dart';
import 'package:qantum_apps/core/extensions/spacer_extension.dart';

import '../../../core/utils/AppColors.dart';
import '../../../l10n/app_localizations.dart';

class SignupErrorDialog {
  static final SignupErrorDialog _instance = SignupErrorDialog._internal();

  static getInstance() {
    return _instance;
  }

  SignupErrorDialog._internal();

  showSignupErrorDialog(BuildContext context) {
    AppLocalizations loc = AppLocalizations.of(context)!;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: AppColors.white,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.txtAlert,
                    style: TextStyle(fontSize: 18, color: AppColors.black),
                  ),
                  10.h,
                  Text("Email ID already in use",
                      style: TextStyle(fontSize: 15, color: AppColors.black)),
                  10.h,
                  Text("Please choose a different email",
                      style: TextStyle(fontSize: 15, color: AppColors.black)),
                  30.h,
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(loc.txtOk.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          );
        });
  }
}
