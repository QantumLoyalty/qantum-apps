import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_camera_overlay/model.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '/core/utils/AppIcons.dart';
import '/core/mixins/logging_mixin.dart';
import '../../core/navigation/AppNavigator.dart';
import '/core/utils/AppHelper.dart';
import '/views/common_widgets/AppLoader.dart';
import '../../view_models/DocumentScanProvider.dart';
import '/core/utils/AppDimens.dart';
import '/views/common_widgets/AppButton.dart';
import '../../l10n/app_localizations.dart';
import '/views/common_widgets/AppScaffold.dart';
import '../common_widgets/AppLogo.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

class DrivingLicenseScanScreen extends StatefulWidget {
  Map<String, String> arguments;

  DrivingLicenseScanScreen({super.key, required this.arguments});

  @override
  State<DrivingLicenseScanScreen> createState() =>
      _DrivingLicenseScanScreenState();
}

class _DrivingLicenseScanScreenState extends State<DrivingLicenseScanScreen>
    with LoggingMixin {
  AppLocalizations? loc;

  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  final CardOverlay overlay = CardOverlay.byFormat(OverlayFormat.cardID1);

  String? _frontImage, _backImage;
  late FlipCardController _flipController;

  @override
  void initState() {
    super.initState();
    _flipController = FlipCardController();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      _controller = CameraController(backCamera, ResolutionPreset.high,
          enableAudio: false);
      _initializeControllerFuture = _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      logEvent("Camera init error: $e");
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(body: SafeArea(child:
        Consumer<DocumentScanProvider>(builder: (context, provider, child) {
      if (provider.isErrorInScan != null) {
        if (provider.isErrorInScan!) {
          AppHelper.showErrorMessage(context, "Error in scanning!!");
        } else {
          if (provider.scannedData != null) {
            Future.delayed(Duration.zero, () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (provider.scannedData!.containsKey("name")) {
                  widget.arguments["name"] = provider.scannedData!["name"];
                }
                if (provider.scannedData!.containsKey("dob")) {
                  widget.arguments["dob"] = provider.scannedData!["dob"];
                }
                if (provider.scannedData!.containsKey("address")) {
                  widget.arguments["address"] =
                      provider.scannedData!["address"];
                }

                provider.uploadDrivingLicenseImages(_frontImage!, _backImage!);
              });
            });
          }
        }

       // provider.resetError();
      }

      if (provider.isErrorInUpload != null) {
        if (provider.isErrorInUpload!) {
          AppHelper.showErrorMessage(context, loc!.msgCommonError);
        } else {
          widget.arguments["license_front"] = provider.frontImageUrl ?? "";
          widget.arguments["license_back"] = provider.backImageUrl ?? "";
          logEvent(widget.arguments.toString());
          Future.delayed(Duration.zero, () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppNavigator.navigateReplacement(context, AppNavigator.signup,
                  arguments: widget.arguments);
            });
          });
        }
        provider.resetError();
      }

      return Stack(
        children: [
          Column(
            children: [
              Applogo(),
              AppDimens.shape_30,
              Expanded(
                  child: FlipCard(
                frontWidget: frontCard(),
                backWidget: backCard(),
                controller: _flipController,
                rotateSide: RotateSide.left,
                axis: FlipAxis.vertical,
                onTapFlipping: false,
              )),
              AppDimens.shape_20,
              InkWell(
                onTap: () {
                  AppNavigator.navigateReplacement(context, AppNavigator.signup,
                      arguments: widget.arguments);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Text(
                    loc!.noLicense,
                    style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
              ),
              AppDimens.shape_20,
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: AppButton(
                    text: loc!.takePhotoBtn,
                    onClick: () {
                      _captureWithCrop(provider);
                    }),
              ),
              AppDimens.shape_10,
            ],
          ),

          /*Column(
            children: [
              Applogo(),
              AppDimens.shape_30,
              Text(
                loc!.takePhotoOf,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              AppDimens.shape_10,
              Text(
                findStatus() == 0 ? loc!.frontOfDL : loc!.backOfDL,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Expanded(
                  child: Column(
                children: [
                  AppDimens.shape_20,
                  Expanded(
                    child: getCentralWidget(),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppIcons.lightBulb,
                          width: 20,
                          height: 20,
                        ),
                        AppDimens.shape_10,
                        Expanded(
                          child: Text(
                            loc!.ensureFits,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
              AppDimens.shape_20,
              InkWell(
                onTap: () {
                  AppNavigator.navigateReplacement(context, AppNavigator.signup,
                      arguments: widget.arguments);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Text(
                    loc!.noLicense,
                    style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
              ),
              AppDimens.shape_20,
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: AppButton(
                    text: loc!.takePhotoBtn,
                    onClick: () {
                      _captureWithCrop(provider);
                    }),
              ),
              AppDimens.shape_10,
            ],
          ),*/
          provider.showLoader != null && provider.showLoader!
              ? AppLoader(
                  loaderMessage: loc!.msgCommonLoader,
                )
              : Container()
        ],
      );
    })));
  }

  Future<void> _captureWithCrop(DocumentScanProvider provider) async {
    await _initializeControllerFuture;

    final rawFile = await _controller!.takePicture();
    final bytes = await File(rawFile.path).readAsBytes();
    final captured = img.decodeImage(bytes)!;

    // 📐 CardOverlay gives ratio (width / height)
    final aspectRatio = overlay.ratio ?? (1.6); // fallback if null

    // We want rectangle ~80% of image width
    final cropW = (captured.width * 0.8).toInt();
    final cropH = (cropW / aspectRatio).toInt();

    // Center it
    final cropX = ((captured.width - cropW) / 2).toInt();
    final cropY = ((captured.height - cropH) / 2).toInt();

    // ✂️ Crop
    final cropped =
        img.copyCrop(captured, x: cropX, y: cropY, width: cropW, height: cropH);

    final dir = await getTemporaryDirectory();
    final croppedFile = File(
        "${dir.path}/cropped_card${DateTime.now().millisecondsSinceEpoch}.png")
      ..writeAsBytesSync(img.encodeJpg(cropped));

    debugPrint("📸 Cropped file saved: ${croppedFile.path}");

    setState(() {
      if (findStatus() == 0) {
        _frontImage = croppedFile.path;
        _flipController.flipcard();
      } else {
        _backImage = croppedFile.path;
        provider.getDrivingLicenseInformation(_frontImage!, _backImage!);
      }
    });
  }

  int findStatus() {
    /// 0 - FRONT captured,
    /// 1 - BACK captured,
    /// 2 - Final done

    if (_frontImage == null && _backImage == null) {
      return 0;
    } else if (_frontImage != null && _backImage == null) {
      return 1;
    } else if (_frontImage != null && _backImage != null) {
      return 2;
    } else {
      return 4;
    }
  }

  Widget getCentralWidget() {
    /// 0 - FRONT captured,
    /// 1 - BACK captured,
    /// 2 - Final done

    int status = findStatus();

    return _initializeControllerFuture != null
        ? FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if ((snapshot.connectionState == ConnectionState.done) &&
                  !snapshot.hasError) {
                return _controller != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        width: _controller!
                                            .value.previewSize!.height,
                                        height: _controller!
                                            .value.previewSize!.width,
                                        child: CameraPreview(_controller!))),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.white, width: 3),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container();
              } else {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc!.fetchingCameras,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                    ),
                    InkWell(
                      onTap: () async {
                        await openAppSettings();
                        _initCamera();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text(
                          loc!.openAppSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                      ),
                    ),
                  ],
                ));
              }
            })
        : Container();
  }

  Widget frontCard() {
    return Column(
      children: [
        Text(
          loc!.takePhotoOf,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
        AppDimens.shape_10,
        Text(
          loc!.frontOfDL,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
        Expanded(
            child: Column(
          children: [
            AppDimens.shape_20,
            Expanded(
              child: getCentralWidget(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppIcons.lightBulb,
                    width: 20,
                    height: 20,
                  ),
                  AppDimens.shape_10,
                  Expanded(
                    child: Text(
                      loc!.ensureFits,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ],
    );
  }

  Widget backCard() {
    return Column(
      children: [
        Text(
          loc!.takePhotoOf,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
        AppDimens.shape_10,
        Text(
          loc!.backOfDL,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
        Expanded(
            child: Column(
          children: [
            AppDimens.shape_20,
            Expanded(
              child: getCentralWidget(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppIcons.lightBulb,
                    width: 20,
                    height: 20,
                  ),
                  AppDimens.shape_10,
                  Expanded(
                    child: Text(
                      loc!.ensureFits,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ],
    );
  }
}
