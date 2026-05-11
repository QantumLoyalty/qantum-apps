import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_scratch_card/flutter_scratch_card.dart';

import '/core/utils/AppColors.dart';
import '/core/utils/AppDimens.dart';

class ScratchCardDialog {
  static final ScratchCardDialog _instance = ScratchCardDialog._internal();

  ScratchCardDialog._internal();

  static ScratchCardDialog getInstance() {
    return _instance;
  }

  showScratchCardDialog(BuildContext context) {
    final media = MediaQuery.of(context);

    final dialogHeight = media.size.height;

    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Theme.of(context).primaryColor,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/common/scratchie_dialog_back.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: dialogHeight,
                  padding: const EdgeInsets.all(25),
                  child: Stack(
                    children: [
                      Container(
                        width: media.size.width,
                        height: dialogHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            AppDimens.shape_50,
                            /*const ScratchAndWinTextStyle(
                              skewX: 0.02,
                              lines: [
                                ScratchWinLine(text: 'SCRATCH', fontSize: 54),
                                ScratchWinLine(text: 'AND', fontSize: 28),
                                ScratchWinLine(text: 'WIN!', fontSize: 60),
                              ],
                            ),*/

                            Image.asset(
                              "assets/common/scratch_and_win_text.png",
                            ),
                            /*Stack(
                              children: [
                                Text(
                                  'SCRATCH\nAND WIN!',
                                  style: TextStyle(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w900,
                                    height: 0.9,
                                    letterSpacing: 2,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 14
                                      ..color = const Color(0xFF20104F),
                                  ),
                                ),
                                Text(
                                  'SCRATCH\nAND WIN!',
                                  style: TextStyle(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w900,
                                    height: 0.9,
                                    letterSpacing: 2,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = const Color(0xFFFF6A00),
                                  ),
                                ),
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFFF35A),
                                      Color(0xFFFFB000),
                                      Color(0xFFFF7A00),
                                    ],
                                  ).createShader(bounds),
                                  child: const Text(
                                    'SCRATCH\nAND WIN!',
                                    style: TextStyle(
                                      fontSize: 72,
                                      fontWeight: FontWeight.w900,
                                      height: 0.9,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),*/
                            AppDimens.shape_30,
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.width * 0.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Image.asset(
                                            "assets/common/scratchie_back.png")),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsetsGeometry.all(15),
                                        child: ScratchCard(
                                            scratchColor:
                                                Theme.of(context).primaryColor,
                                            overlayImageAsset:
                                                "assets/common/scratch-card.png",
                                            autoReveal: true,
                                            // Automatically fade out the overlay after threshold
                                            threshold: 0.4,
                                            progressTriggers: const [0.5],
                                            animationType:
                                                ScratchAnimationType.lottie,
                                            animationAsset:
                                                'assets/common/party_pop.json',
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    /* ScratchAndWinTextStyle(
                                                      skewX: 0.02,
                                                      lines: [
                                                        ScratchWinLine(
                                                            text: 'YOU',
                                                            fontSize: 48),
                                                        ScratchWinLine(
                                                            text: 'WON!',
                                                            fontSize: 48),
                                                      ],
                                                    ),*/
                                                    Image.asset(
                                                        "assets/common/you_won.png",
                                                        height: 120),
                                                    Text(
                                                      "\$100",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor,
                                                          fontSize: 48,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w900),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
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
                                        color: AppColors.black
                                            .withValues(alpha: 0.5),
                                        offset: const Offset(1.0, 1.0),
                                        blurRadius: 3.0)
                                  ],
                                )),
                          ))
                    ],
                  ),
                ),
              ],
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
