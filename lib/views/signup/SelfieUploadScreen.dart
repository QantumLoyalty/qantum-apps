import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_overlay_new/model.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/navigation/route_observer.dart';
import '/views/common_widgets/AppLoader.dart';
import '/view_models/UserInfoProvider.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../../l10n/app_localizations.dart';
import '../common_widgets/AppLogo.dart';
import '/views/common_widgets/AppScaffold.dart';

class SelfieUploadScreen extends StatefulWidget {
  const SelfieUploadScreen({super.key});

  @override
  State<SelfieUploadScreen> createState() => _SelfieUploadScreenState();
}

class _SelfieUploadScreenState extends State<SelfieUploadScreen>
    with LoggingMixin, WidgetsBindingObserver, RouteAware {
  AppLocalizations? loc;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  final GlobalKey _frameKey = GlobalKey();

  final CardOverlay overlay = CardOverlay.byFormat(OverlayFormat.cardID1);

  String? _selfieImage;

  late UserInfoProvider _userInfoProvider;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initCamera();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  /// Handle app pause/resume to prevent freeze on iOS
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_controller == null) return;

    if (state == AppLifecycleState.paused) {
      // iOS background
      await _controller?.pausePreview();
    } else if (state == AppLifecycleState.resumed) {
      // Resume preview only
      if (_controller != null && _controller!.value.isInitialized) {
        await _controller?.resumePreview();
      }
    }
  }

  Future<void> _initCamera() async {
    try {
      // Add a small delay on iOS after the permission popup
      if (Platform.isIOS) {
        await Future.delayed(const Duration(milliseconds: 300));
      }

      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      _controller = CameraController(backCamera, ResolutionPreset.high,
          enableAudio: false);
      _initializeControllerFuture = _controller!.initialize().then((_) async {
        try {
          await _controller?.setFlashMode(FlashMode.off);
        } on CameraException catch (e) {
          debugPrint("Set flash mode error: ${e.code} ${e.description}");
        } catch (e) {
          logEvent("Set flash mode error: $e");
        }
      });
      if (mounted) {
        setState(() {});
      }
    } on CameraException catch (e) {
      debugPrint("Camera error: ${e.code} ${e.description}");
    } catch (e) {
      logEvent("Camera init error: $e");
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    // _controller!.dispose();
    /*_controller?.dispose();
    _controller = null;
    _initializeControllerFuture = null;*/
    _disposeCamera();
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when user comes back to this screen
    _restartCamera();
    super.didPopNext();
  }

  void _disposeCamera() {
    _controller?.dispose();
    _controller = null;
    _initializeControllerFuture = null;
  }

  Future<void> _restartCamera() async {
    // Dispose everything first
    await _controller?.dispose();
    _controller = null;
    _initializeControllerFuture = null;

    if (!mounted) return;

    setState(() {}); // forces FutureBuilder to reset

    await _initCamera(); // creates NEW controller + NEW future
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context);

    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      if (provider.uploadedSelfie != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppNavigator.navigateReplacement(
            context,
            AppNavigator.choosePaymentMethod,
          );
        });

        provider.resetUploadedSelfie();
      }

      return AppScaffold(
          body: Stack(
        children: [
          _initializeControllerFuture != null
              ? FutureBuilder(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if ((snapshot.connectionState == ConnectionState.done) &&
                        !snapshot.hasError) {
                      print(
                          "Controller Value $_controller && Status ${_controller!.value.isInitialized}");

                      return (_controller != null &&
                              _controller!.value.isInitialized)
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
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
                            )
                          : Container();
                    } else {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
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
                            GestureDetector(
                              onTap: () async {
                                print('Open settings clicked!!');
                                await openAppSettings();
                                _initCamera();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15, bottom: 15),
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
                        ),
                      ));
                    }
                  })
              : Container(),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                AppDimens.shape_50,
                Applogo(),
                AppDimens.shape_20,
                Text(
                  loc!.pleaseTakeSelfie,
                  style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 20),
                ),
                AppDimens.shape_30,
                Expanded(
                    child: Container(
                  key: _frameKey,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                )),
                Material(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                      side: BorderSide(color: AppColors.white, width: 1)),
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      radius: 80.0,
                      onTap: () {
                        _captureWithCrop();
                      },
                      child: Icon(
                        Icons.circle,
                        color: AppColors.white,
                        size: 65,
                      ),
                    ),
                  ),
                ),
                AppDimens.shape_30,
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
                          loc!.faceInWhiteFrame,
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
                ),
                AppDimens.shape_40,
              ],
            ),
          ),
          provider.showLoader != null && provider.showLoader!
              ? AppLoader(
                  loaderMessage: loc!.uploadingSelfie,
                )
              : Container()
        ],
      ));
    });
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
    //final cropH = (cropW / aspectRatio).toInt();
    final cropH = (cropW).toInt();

    // Center it
    final cropX = ((captured.width - cropW) / 2).toInt();
    final cropY = ((captured.height - cropH) / 2).toInt();

    // ✂️ Crop
    final cropped =
        img.copyCrop(captured, x: cropX, y: cropY, width: cropW, height: cropH);

    // --- 1️⃣ Get white box position on screen ---
    /*final renderBox =
    _frameKey.currentContext!.findRenderObject() as RenderBox;
    final frameSize = renderBox.size;
    print("Frame Size: ${frameSize.width} --> ${frameSize.height}");
    final framePosition = renderBox.localToGlobal(Offset.zero);


// --- 2️⃣ Get CameraPreview size ---
    final previewSize = _controller!.value.previewSize!;
    final screenSize = MediaQuery.of(context).size;
    print("Screen Size: ${screenSize.width} --> ${screenSize.height}");
    // CameraPreview is rotated in portrait
    final imageWidth = captured.width.toDouble();
    final imageHeight = captured.height.toDouble();

    final previewWidth = _controller!.value.previewSize!.height;
    final previewHeight = _controller!.value.previewSize!.width;

    // --- 3️⃣ Calculate scale between preview & image ---
    final scaleX = imageWidth / previewHeight;
    final scaleY = imageHeight / previewWidth;

    // --- 4️⃣ Map white box to image pixels ---
    final cropX = (framePosition.dy * scaleX).toInt();
    final cropY = (framePosition.dx * scaleY).toInt();
    final cropW = (frameSize.height * scaleX).toInt();
    final cropH = (frameSize.width * scaleY).toInt();

    // --- 5️⃣ Safety clamp ---
    final safeX = cropX.clamp(0, captured.width - 1);
    final safeY = cropY.clamp(0, captured.height - 1);
    final safeW = cropW.clamp(1, captured.width - safeX);
    final safeH = cropH.clamp(1, captured.height - safeY);

    // --- 6️⃣ Crop exactly under white box ---
    final cropped = img.copyCrop(
      captured,
      x: safeX,
      y: safeY,
      width: safeW,
      height: safeH,
    );*/

    final dir = await getTemporaryDirectory();
    final croppedFile = File(
        "${dir.path}/cropped_selfie${DateTime.now().millisecondsSinceEpoch}.png")
      ..writeAsBytesSync(img.encodeJpg(cropped));

    /*final dir = await getTemporaryDirectory();
    final croppedFile = File(
      "${dir.path}/selfie_${DateTime.now().millisecondsSinceEpoch}.jpg",
    )..writeAsBytesSync(img.encodeJpg(cropped, quality: 95));*/

    debugPrint("📸 Cropped file saved: ${croppedFile.path}");

    setState(() {
      _selfieImage = croppedFile.path;
      //showCroppedImage(_selfieImage!);
      _userInfoProvider.uploadUserSelfieImage(_selfieImage!);
    });
  }

  showCroppedImage(String selfieImage) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCEL")),
              Expanded(child: Image.file(File(selfieImage))),
            ],
          ));
        });
  }
}
