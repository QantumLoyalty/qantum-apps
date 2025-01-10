import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../view_models/UserInfoProvider.dart';

class SpecialOfferDetailDialog {
  static final SpecialOfferDetailDialog _specialOfferDetailDialog =
      SpecialOfferDetailDialog._internal();

  static SpecialOfferDetailDialog getInstance() {
    return _specialOfferDetailDialog;
  }

  SpecialOfferDetailDialog._internal();

  showSpecialOfferDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Consumer<UserInfoProvider>(
                    builder: (context, provider, child) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.65 - 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: SizedBox(
                                height: 180,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/common/special_offers_placeholder.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppDimens.shape_10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Brewdog Punk XPA 4pk \$14',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Present this voucher to receive a 4 pack of Brewdog Punk XPA for \$14',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'Valid to 25.01.25',
                                          style: TextStyle(
                                              color: AppColors.bright_sky_blue,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppDimens.shape_5,
                                  QrImageView(
                                    data: '${provider.getUserInfo!.cardNumber}',
                                    backgroundColor: AppColors.white,
                                    size: 150,
                                  ),
                                  AppDimens.shape_20,
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 50,
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 30,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  size: 30,
                                  color: AppColors.bright_sky_blue,
                                )),
                          ))
                    ],
                  );
                }),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
            child: SlideTransition(
              position:
                  Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child,
            ),
          );
        });
  }
}
