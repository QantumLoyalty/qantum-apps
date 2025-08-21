import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '/core/navigation/AppNavigator.dart';
import '../../data/models/PromotionModel.dart';
import '../my_venues/widgets/PromotionsPlaceHolder.dart';

class PromotionDetailDialog {
  static final PromotionDetailDialog _promotionDetailDialog =
      PromotionDetailDialog._internal();

  static PromotionDetailDialog getInstance() {
    return _promotionDetailDialog;
  }

  PromotionDetailDialog._internal();

  showPromotionDetailDialog(
      BuildContext context, PromotionItem promotion, String from) {
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, anim1, anim2) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          width: MediaQuery.of(context).size.width,
                          height:
                              MediaQuery.of(context).size.height * 0.80 - 80,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      fit: from == "SMALL"
                                          ? BoxFit.contain
                                          : BoxFit.cover,
                                      imageUrl: promotion.imageUrl ?? "",
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
                                      errorWidget: (context, _, obj) {
                                        return PromotionsPlaceHolder(
                                            size: Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                MediaQuery.of(context)
                                                    .size
                                                    .height));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: SingleChildScrollView(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10))),
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          bottom: 20,
                                          right: 10),
                                      child: Html(
                                        data: promotion.htmlContent,
                                        onLinkTap: (String? url,
                                            Map<String, String> attributes, _) {
                                          AppNavigator.navigateTo(
                                              context, AppNavigator.appWebView,
                                              arguments: url);
                                        },
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 60,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
              ),
            );
          });
        },
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
