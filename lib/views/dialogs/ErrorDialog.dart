import 'package:flutter/material.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppStrings.dart';

class ErrorDialog {
  static final ErrorDialog _errorDialog = ErrorDialog._internal();

  static ErrorDialog getInstance() {
    return _errorDialog;
  }

  ErrorDialog._internal();

  showErrorDialog(BuildContext context,
      {String? title, required String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppDimens.shape_10,
                  Icon(
                    Icons.cancel_outlined,
                    size: 72,
                    color: AppColors.error_red,
                  ),
                  AppDimens.shape_15,
                  Text(
                    title ?? "Alert!",
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  AppDimens.shape_10,
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.black, fontSize: 14),
                  ),
                  AppDimens.shape_20,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.txtOk.toUpperCase(),
                          style: TextStyle(color: AppColors.error_red),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }
}
