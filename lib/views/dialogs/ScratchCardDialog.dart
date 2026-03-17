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
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.white,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Scratch To See Reward",
                    style: TextStyle(fontSize: 16),
                  ),
                  AppDimens.shape_20,
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: ScratchCard(
                        scratchColor: Theme.of(context).primaryColor,
                        overlayImageAsset: "assets/common/scratch-card.jpg",
                        autoReveal: true, // Automatically fade out the overlay after threshold
                        threshold: 0.6,
                        progressTriggers: const [0.5],
                        animationType: ScratchAnimationType.lottie,
                        animationAsset: 'assets/common/party_pop.json',
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 120,
                            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(80)),
                            child: Center(
                              child: Text(
                                "\$100 WON",
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
