import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/HomeProvider.dart';
import '../../view_models/SpecialOffersProvider.dart';
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
                height: MediaQuery.of(context).size.height * 0.80,
                child: Consumer2<UserInfoProvider, SpecialOffersProvider>(
                    builder: (context, provider, offerProvider, child) {
                  return offerProvider.selectedOffer != null
                      ? Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.80 -
                                      80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: AspectRatio(
                                      aspectRatio: 16/9,
                                      child: CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl: offerProvider
                                                  .selectedOffer!.image ??
                                              "",
                                          placeholder: (context, _) {
                                            return const Stack(
                                              children: [
                                                Center(
                                                  child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          CircularProgressIndicator()),
                                                ),
                                              ],
                                            );
                                          },
                                          errorWidget: (context, a, object) {
                                            return const AspectRatio(
                                                aspectRatio: 16/9,
                                                child: Icon(Icons.image,
                                                    color: Colors.black));
                                          }),
                                    ),
                                  ),
                                  Expanded(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppDimens.shape_10,
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${offerProvider.selectedOffer!.header}',
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${offerProvider.selectedOffer!.description}',
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 14),
                                              ),
                                              AppDimens.shape_5,
                                              Text(
                                                '${AppLocalizations.of(context)!.txtValidTo} ${offerProvider.selectedOffer!.expiryDate}',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .buttonTheme
                                                        .colorScheme!
                                                        .primary,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AppDimens.shape_5,
                                        QrImageView(
                                          data:
                                              '${offerProvider.selectedOffer != null ? offerProvider.selectedOffer!.qrURL : "1"}',
                                          backgroundColor: AppColors.white,
                                          size: 180,
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
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .updateSelectedOption(1);
                                        Provider.of<SpecialOffersProvider>(
                                                context,
                                                listen: false)
                                            .getSpecialOffers(showLoader: true);
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        size: 30,
                                        color: AppThemeCustom.getCloseBtnDialogColor(context)
                                      )),
                                ))
                          ],
                        )
                      : Container();
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
