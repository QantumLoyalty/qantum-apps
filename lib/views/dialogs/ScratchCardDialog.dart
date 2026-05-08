import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_scratch_card/flutter_scratch_card.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';

class ScratchCardDialog {
  static final ScratchCardDialog _instance = ScratchCardDialog._internal();

  ScratchCardDialog._internal();

  static ScratchCardDialog getInstance() {
    return _instance;
  }

  showScratchCardDialog(BuildContext context) {
    double heightFactor = 0.5;

    final media = MediaQuery.of(context);

    final dialogHeight = media.size.height * heightFactor;

    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              height: dialogHeight,
              child: Stack(
                children: [
                  Container(
                    width: media.size.width,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    height: dialogHeight - 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppDimens.shape_40,
                        Text(
                          "Scratch To See Reward",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        AppDimens.shape_20,
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ScratchCard(
                                scratchColor: Theme.of(context).primaryColor,
                                overlayImageAsset:
                                    "assets/common/scratch-card.jpg",
                                autoReveal: true,
                                // Automatically fade out the overlay after threshold
                                threshold: 0.7,
                                progressTriggers: const [0.5],
                                animationType: ScratchAnimationType.lottie,
                                animationAsset: 'assets/common/party_pop.json',
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "\$100 WON",
                                        style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 50,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 30,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            tooltip: "close",
                            icon: Icon(
                              Icons.clear,
                              size: 30,
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                    color:
                                        AppColors.black.withValues(alpha: 0.5),
                                    offset: const Offset(1.0, 1.0),
                                    blurRadius: 3.0)
                              ],
                            )),
                      ))
                ],
              ),
            ),
          );
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
