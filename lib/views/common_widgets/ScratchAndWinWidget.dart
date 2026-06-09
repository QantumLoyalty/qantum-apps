import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scratch_card/flutter_scratch_card.dart';
import 'package:provider/provider.dart';
import '/core/utils/AppColors.dart';
import '/view_models/PromotionsProvider.dart';
import '../../core/extensions/log_extension.dart';
import '../../core/extensions/spacer_extension.dart';
import '../../core/utils/AppDimens.dart';
import '../../data/models/incentives/SmartIncentivesResponse.dart';
import '../../l10n/app_localizations.dart';
import 'MetallicGradientText.dart';

class ScratchAndWinWidget extends StatefulWidget {
  MatchedIncentive incentive;

  ScratchAndWinWidget({super.key, required this.incentive});

  @override
  State<ScratchAndWinWidget> createState() => _ScratchAndWinWidgetState();
}

class _ScratchAndWinWidgetState extends State<ScratchAndWinWidget> {
  bool isScratched = false;
  bool _hasTriggeredConsume = false;
  bool _hasPlayedSound = false;
  late AppLocalizations loc;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  void _initializeAudio() async {
    try {
      // 1. Pre-cache the track source location
      _audioPlayer.setSource(AssetSource("audio/scratching.mp3"));

      // 2. Set loop mode so the audio doesn't cut out mid-scratch sequence
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      e.toString().logMessage();
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final dialogHeight = media.size.height;
    final width = media.size.width;
    final loc = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/common/scratchie_dialog_back.png",
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: dialogHeight,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AppDimens.shape_50,
                Image.asset(
                  "assets/common/scratch_and_win_text.png",
                ),
                AppDimens.shape_30,
                SizedBox(
                  width: width * 0.8,
                  height: width * 0.8,
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
                            child: Listener(
                              onPointerMove: (event) {
                                _playScratchSound();
                              },
                              onPointerUp: (event) {
                                _stopAudio();
                              },
                              onPointerCancel: (event) {
                                _stopAudio();
                              },
                              child: ScratchCard(
                                  scratchColor: Theme.of(context).primaryColor,
                                  overlayImageAsset:
                                      "assets/common/scratch-card.png",
                                  autoReveal: true,
                                  threshold: 0.4,
                                  onThreshold: () {
                                    _stopAudio();
                                  },
                                  onProgress: (value) {
                                    "Reveal Progress: $value".logMessage();

                                    if (value == 1.0 && !_hasTriggeredConsume) {
                                      setState(() {
                                        isScratched = true;
                                        _hasTriggeredConsume = true;
                                      });
                                       context
                                          .read<PromotionsProvider>()
                                          .consumeSmartIncentive(
                                              widget.incentive.incentiveId);
                                    }
                                  },
                                  progressTriggers: const [0.5],
                                  animationType: ScratchAnimationType.lottie,
                                  animationAsset:
                                      'assets/common/party_pop.json',
                                  child: Container(
                                    width: width * 0.6,
                                    height: width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                              "assets/common/you_won.png",
                                              height: 120),
                                          Text(
                                            "${widget.incentive.incentiveValue}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 48,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            "Points",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppDimens.shape_30,
                SizedBox(
                  width: width * 0.9,
                  child: AnimatedOpacity(
                    opacity: isScratched ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: GestureDetector(
                      onTap: () {
                        if (isScratched) Navigator.pop(context);
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                                "assets/common/congrats_ok_button.png"),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MetallicGradientText(
                                      text:
                                          loc.txtCongratulations.toUpperCase(),
                                      fontSize: 32,
                                    ),
                                    const Text("Prize is paid in points."),
                                    5.h,
                                    const Text(
                                      "It is in your\nPoints account now!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    20.h,
                                    InkWell(
                                        onTap: () {
                                          if (isScratched) Navigator.pop(context);
                                        },
                                        child: Text(
                                          loc.txtOk.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child:
              Consumer<PromotionsProvider>(builder: (context, provider, child) {
            if (provider.consumeIncentiveMessage == null) {
              return const SizedBox.shrink();
            }

            return Container(
              decoration: BoxDecoration(
                  color: AppColors.error_red,
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(left: 18, right: 18, bottom: 25),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "Ooppss.. something went wrong, please try again later",
                    style: TextStyle(color: AppColors.white),
                  )),
                  15.w,
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel, color: AppColors.white))
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  void _stopAudio() async {
    if (_hasPlayedSound) {
      setState(() {
        _hasPlayedSound = false;
      });
      await _audioPlayer
          .pause(); // Pausing preserves state; avoids player lock-ups
    }
  }

  void _playScratchSound() async {
    ("Scratch sound triggered").logMessage();
    if (!_hasPlayedSound) {
      setState(() {
        _hasPlayedSound = true; // Lock the trigger so it doesn't spam play
      });

      // Rewind to the beginning and play
      // await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.resume();
    }
  }
}
