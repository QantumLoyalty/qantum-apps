import 'package:flutter/material.dart';
import '/core/navigation/AppNavigator.dart';
import '/core/utils/AppColors.dart';
import '/core/utils/AppDimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PartnerOfferDetailScreen extends StatelessWidget {
  const PartnerOfferDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
            Card(
                color: AppColors.blue,
                child: Column(
                  children: [
                    Column(
                      children: [
                        AppDimens.getCustomBoxShape(70),
                        Container(
                          height: 150,
                          color: Colors.pink,
                        ),
                        AppDimens.shape_20,
                        Row(
                          children: [
                            Expanded(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'NAME',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.dark_blue,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            'User Name',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.sky_blue),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'ASSOCIATION',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.dark_blue,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            'Qantum Network',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.sky_blue,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                    AppDimens.shape_20,
                    QrImageView(
                      backgroundColor: AppColors.white,
                      data: '1234567890',
                      size: 150,
                      version: QrVersions.auto,
                    ),
                    AppDimens.shape_20,
                  ],
                )),
            AppDimens.shape_20,
            Text(
              'By using this QR code, you agree that you have read and accept the Terms and conditions.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
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
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  fontSize: 14),
            ),
                    ],
                  ),
                ),
            ),
          ),
        );
  }
}
