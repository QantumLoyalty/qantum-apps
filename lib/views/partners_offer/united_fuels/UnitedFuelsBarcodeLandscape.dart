import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';

import '../widget/BarcodeView.dart';

class UnitedFuelsBarcodeLandscape extends StatefulWidget {
  const UnitedFuelsBarcodeLandscape({super.key});

  @override
  State<UnitedFuelsBarcodeLandscape> createState() => _UnitedFuelsBarcodeLandscapeState();
}

class _UnitedFuelsBarcodeLandscapeState extends State<UnitedFuelsBarcodeLandscape> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

  }

  @override
  void dispose() {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.white,body: Center(child: BarcodeView(alignment: BarcodeView.LANDSCAPE,)),);
  }
}
