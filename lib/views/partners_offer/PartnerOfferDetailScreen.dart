import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PartnerOfferDetailScreen extends StatelessWidget {
  const PartnerOfferDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AppNavigator.goBack(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          children: [
            Expanded(
                child: Card(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(10),
                                color: Colors.pink,
                              )),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        'NAME',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'User Name',
                                        style:
                                            TextStyle(color: Colors.blue[200]),
                                      )
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        'ASSOCIATION',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Qantum Network',
                                        style:
                                            TextStyle(color: Colors.blue[200]),
                                      )
                                    ],
                                  )),
                                ],
                              )
                            ],
                          ),
                        )),
                        AppDimens.shape_20,
                        QrImageView(
                          backgroundColor: AppColors.white,
                          data: '1234567890',
                          size: 150,
                          version: QrVersions.auto,
                        ),
                        AppDimens.shape_20,
                      ],
                    ))),
            AppDimens.shape_20,
            Text(
              'By using this QR code, you agree that you have read and accept the Terms and conditions.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  fontSize: 14),
            ),
            AppDimens.shape_20,
            Text(
              'This digital card cannot be used at 24hr Ufil self serve locations.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    ));
  }
}
