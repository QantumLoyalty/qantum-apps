import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '/l10n/app_localizations.dart';
import '/core/utils/AppHelper.dart';
import '/view_models/SpecialOffersProvider.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../view_models/HomeProvider.dart';
import '/data/models/OfferModel.dart';
import '../../../core/utils/AppColors.dart';
import '../SpecialOfferDetailDialog.dart';

class SpecialOfferItem extends StatelessWidget {
  OfferModel offer;

  SpecialOfferItem({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: InkWell(
        onTap: () async {
          await Provider.of<SpecialOffersProvider>(context, listen: false)
              .getOfferByID(offerID: offer.id!);

          if (context.mounted) {
            Provider.of<HomeProvider>(context, listen: false)
                .updateShowAllMenuVisibility(false, "Special Offers Item");

            if (Provider.of<SpecialOffersProvider>(context, listen: false)
                    .selectedOffer !=
                null) {
              Provider.of<SpecialOffersProvider>(context, listen: false)
                  .selectedOffer!
                  .expiryDate = offer.expiryDate;

              await SpecialOfferDetailDialog.getInstance()
                  .showSpecialOfferDialog(context);
            }
          } else {
            if (!context.mounted) return;
            AppHelper.showErrorMessage(context, "Something went wrong.");
          }
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 10,
              top: 0,
              bottom: 0,
              child: Card(
                color: AppColors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: AspectRatio(
                        aspectRatio: 1.1,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          imageUrl: offer.image ?? "",
                          placeholder: (context, _) {
                            return const Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      )),
                                ),
                              ],
                            );
                          },
                          errorWidget: (context, a, object) {
                            return const AspectRatio(
                                aspectRatio: 1.1,
                                child: Icon(Icons.image, color: Colors.black));
                          },
                        ),
                      ),
                    ),
                    AppDimens.shape_10,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${offer.header}",
                                maxLines: 1,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            Text("${offer.description}",
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 11)),
                            AppDimens.shape_5,
                            Text(
                              '${AppLocalizations.of(context)!.txtValidTo} ${offer.expiryDate}',
                              style: TextStyle(
                                fontSize: 8,
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppDimens.shape_15,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.white,
                child: Icon(
                  Icons.chevron_right,
                  size: 25,
                  color: AppThemeCustom.getCloseBtnDialogColor(context)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
