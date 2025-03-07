import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';

import '../../core/utils/AppDimens.dart';

class PartnerOfferDialog {
  static PartnerOfferDialog partnerOfferDialog = PartnerOfferDialog._internal();

  static PartnerOfferDialog getInstance() {
    return partnerOfferDialog;
  }

  PartnerOfferDialog._internal();

  showPartnerOfferDialog(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7 - 80,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/common/partner_offer_placeholder.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppDimens.shape_20,
                                  Text(
                                    'United 24 Fuel Stations',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Scan your card to save 4c per litre.',
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 14),
                                  ),
                                  AppDimens.shape_10,
                                  Text(
                                    'Valid to 25.01.25',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .primary,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          )),
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
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary,
                              )),
                        ))
                  ],
                ),
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
