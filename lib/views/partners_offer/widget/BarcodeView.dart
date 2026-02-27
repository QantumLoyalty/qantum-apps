import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppDimens.dart';

class BarcodeView extends StatelessWidget {

  static const int VERTICAL=1;
  static const int HORIZONTAL=2;
  late int alignment;
   BarcodeView({super.key, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20),child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: SfBarcodeGenerator(
            value: 'Qantum',
            symbology: Code128(),
            textSpacing: 2,
            //    symbology: QRCode(),
          ),
        ),
        AppDimens.shape_10,
        Text(
          "Scan this barcode in-store to redeem",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
            child: Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Text(
                  "View barcode in landscape",
                  style: TextStyle(
                      color: AppColors.blue,
                      decorationColor: AppColors.blue,
                      decoration: TextDecoration.underline),
                ))),
      ],
    ));
  }
}
