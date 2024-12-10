import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/utils/AppColors.dart';

class MyDigitalCardScreen extends StatelessWidget {
  const MyDigitalCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2)),
            color: Colors.blue,
            child: Center(
              child: QrImageView(
                backgroundColor: AppColors.white,
                data: '1234567890',
                size: 120,
                version: QrVersions.auto,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
