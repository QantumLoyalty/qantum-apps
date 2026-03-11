import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import '/view_models/UnitedFuelsProvider.dart';
import 'BarcodeView.dart';
import 'UnitedTermsList.dart';

class UnitedDataPart extends StatelessWidget {
  const UnitedDataPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitedFuelsProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          (provider.isError && provider.errorMessage.isNotEmpty)
              ? Center(child: Text(provider.errorMessage,style: TextStyle(color: AppColors.error_red),))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BarcodeView(
                      alignment: BarcodeView.PORTRAIT,
                    ),
                    const UnitedTermsList()
                  ],
                )
        ],
      );
    });
  }
}
