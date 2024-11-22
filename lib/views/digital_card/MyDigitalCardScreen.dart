import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/utils/AppColors.dart';

class MyDigitalCardScreen extends StatelessWidget {
  const MyDigitalCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      child: Card(
        color: Colors.blue,
        child: Center(
          child: QrImageView(
            backgroundColor: AppColors.white,
            data: '1234567890',
            size: 150,
            version: QrVersions.auto,
          ),
        ),
      ),
    );
  }
}
