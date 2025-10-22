import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_camera_overlay/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/mixins/logging_mixin.dart';
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
  bool preview = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameraPermission = await Permission.camera.status;
    final micPermission = await Permission.microphone.status;

 if (!cameraPermission.isGranted || !micPermission.isGranted) {
      final newStatus = await [
        if (!cameraPermission.isGranted) Permission.camera,
        if (!micPermission.isGranted) Permission.microphone
      ].request();
// Step 3: Evaluate new results
      final cameraGranted =
          newStatus[Permission.camera]?.isGranted ?? cameraPermission.isGranted;
      final micGranted = newStatus[Permission.microphone]?.isGranted ??
          micPermission.isGranted;

      if (!cameraGranted || !micGranted) {
        // Handle permanently denied case
        if (newStatus[Permission.camera]?.isPermanentlyDenied == true ||
            newStatus[Permission.microphone]?.isPermanentlyDenied == true) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Permission Required",
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                "Camera and Microphone permissions are required.\n"
                "Please enable them from App Settings to continue.",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await openAppSettings();
                  },
                  child: const Text(
                    "Open Settings",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle temporary denial
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Permission Needed",
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                "Camera and Microphone permissions are required to scan your document.",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _initCamera(); // re-try cleanly
                  },
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }
        return;
      }
    }


    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);

    _controller = CameraController(
      backCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) {
      setState(() {});
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
      if (provider.isError != null) {
        if (provider.isError!) {
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

                AppNavigator.navigateReplacement(context, AppNavigator.signup,
                    arguments: widget.arguments);
              });
            });
          }
        }

        provider.resetError();
      }

      return Stack(
        children: [
          Column(
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
                          "assets/common/lightbulb.png",
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
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: AppButton(
                    text: (findStatus() == 4)
                        ? "SUBMIT"
                        : (preview ? "Next" : loc!.takePhotoBtn),
                    onClick: () {
                      int status = findStatus();
                      if (status == 0 || status == 2) {
                        _captureWithCrop();
                      } else if (status == 4) {
                        provider.getDrivingLicenseInformation(
                            _frontImage!, _backImage!);
                      } else {
                        setState(() {
                          preview = false;
                        });
                      }
                    }),
              ),
              AppDimens.shape_10,
              FilledButton.icon(
                  icon: Icon(Icons.replay),
                  onPressed: () {
                    int status = findStatus();
                    if (status == 1) {
                      setState(() {
                        _frontImage = null;
                        preview = false;
                      });
                    } else if (status == 3) {
                      setState(() {
                        _backImage = null;
                        preview = false;
                      });
                    } else if (status == 4) {
                      setState(() {
                        _frontImage = null;
                        _backImage = null;
                        preview = false;
                      });
                    } else {
                      setState(() {});
                    }
                  },
                  label: Text(
                    loc!.retakeBtn,
                  ))
            ],
          ),
          provider.showLoader != null && provider.showLoader!
              ? AppLoader()
              : Container()
        ],
      );
    })));
  }

  Future<void> _captureWithCrop() async {
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
        preview = true;
      } else {
        _backImage = croppedFile.path;
        preview = true;
      }
    });
  }

  int findStatus() {
    /// 0 - initial,
    /// 1 - front preview,
    /// 2 - BACK captured,
    /// 3 - back preview,
    /// 4 -  Final done

    if (_frontImage == null && _backImage == null) {
      return 0;
    } else if (_frontImage != null && preview && _backImage == null) {
      return 1;
    } else if (_frontImage != null && !preview && _backImage == null) {
      return 2;
    } else if (_frontImage != null && preview && _backImage != null) {
      return 3;
    } else {
      return 4;
    }
  }

  Widget getCentralWidget() {
    /// 0 - initial,
    /// 1 - front preview,
    /// 2 - BACK captured,
    /// 3 - back preview,
    /// 4 -  Final done

    int status = findStatus();
    if (status == 0 || status == 2) {
      return FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
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
                                width: _controller!.value.previewSize!.height,
                                height: _controller!.value.previewSize!.width,
                                child: CameraPreview(_controller!))),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                  child: Text(
                loc!.fetchingCameras,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ));
            }
          });
    } else if (status == 1) {
      return Image.file(File(_frontImage!));
    } else if (status == 3) {
      return Image.file(File(_backImage!));
    } else {
      return SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(child: Image.file(File(_frontImage!))),
            AppDimens.shape_10,
            Expanded(child: Image.file(File(_backImage!))),
          ],
        ),
      );
    }
  }
}
