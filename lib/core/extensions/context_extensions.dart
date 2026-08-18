import 'package:flutter/material.dart';

import '../utils/AppColors.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  void showSuccessMessage({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.success_green,
    ));
  }

  void showErrorMessage({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.error_red,
    ));
  }
}
