import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/navigation/AppNavigator.dart';
import '/view_models/UnitedFuelsProvider.dart';
import '/views/common_widgets/AppButton.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppDimens.dart';

class BarcodeView extends StatelessWidget {
  static const int PORTRAIT = 1;
  static const int LANDSCAPE = 2;
  late int alignment;

  BarcodeView({super.key, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitedFuelsProvider>(builder: (context,provider,child){

      if(provider.barcode!=null)
        {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: SfBarcodeGenerator(
                      value: provider.barcode!.trim(),
                      symbology: Code128(module: 2),
                      textSpacing: 2,
                    ),
                  ),
                  AppDimens.shape_10,
                  (alignment == PORTRAIT)
                      ? Column(
                    children: [
                      const Text(
                        "Scan this barcode in-store to redeem",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            AppNavigator.navigateTo(context,
                                AppNavigator.unitedFuelsBarcodeLandscape,
                                arguments: alignment);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 5, bottom: 5),
                              child: Text(
                                "View barcode in landscape",
                                style: TextStyle(
                                    color: AppColors.blue,
                                    decorationColor: AppColors.blue,
                                    decoration: TextDecoration.underline),
                              ))),
                    ],
                  )
                      :  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: 120,
                    child: AppButton(
                        text: "DONE",
                        onClick: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ));
        }
      return const SizedBox.shrink();

    });
  }
}
