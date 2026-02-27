import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import 'package:qantum_apps/views/common_widgets/AppButton.dart';
import 'package:qantum_apps/views/common_widgets/AppScaffold.dart';
import 'package:qantum_apps/views/partners_offer/widget/UnitedTermsList.dart';
import 'package:qantum_apps/views/partners_offer/widget/UnitedTopHeader.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../core/utils/AppIcons.dart';

class UnitedFuelMainScreen extends StatelessWidget {
  const UnitedFuelMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context);

    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  AppDimens.shape_10,
                  UnitedTopHeader(),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Save on fuels",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Find your nearest participating\nUnited service station",
                                    style: TextStyle(
                                        color: AppColors.blue,
                                        decorationColor: AppColors.blue,
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              )),
                              Image.asset(
                                AppIcons.unitedFuelsRounded7c,
                                width: 80,
                                height: 80,
                              )
                            ],
                          ),
                          AppDimens.shape_20,
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              child: Padding(padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),child: Text(
                                "View barcode in landscape",
                                style: TextStyle(
                                    color: AppColors.blue,
                                    decorationColor: AppColors.blue,
                                    decoration: TextDecoration.underline),
                              ))),

                          AppDimens.shape_30,

                          UnitedTermsList()



                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 120,
                    child: AppButton(
                        text: "DONE",
                        onClick: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              )
            ],
          ),
        ));
  }




}
