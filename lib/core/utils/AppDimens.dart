import 'package:flutter/material.dart';

class AppDimens {
  static const double screenPadding = 20.0;
  static const double defaultButtonMargin = 10.0;
  static const double screenWidth = 1240.0;
  static const double appBarHeight = 60.0;

  /// CONSTANT SHAPES FOR GAPS/MARGINS
  static const shape_5 = SizedBox(
    width: 5,
    height: 5,
  );
  static const shape_10 = SizedBox(
    width: 10,
    height: 10,
  );
  static const shape_15 = SizedBox(
    width: 15,
    height: 15,
  );
  static const shape_20 = SizedBox(
    width: 20,
    height: 20,
  );
  static const shape_30 = SizedBox(
    width: 30,
    height: 30,
  );
  static const shape_40 = SizedBox(
    width: 40,
    height: 40,
  );
  static const shape_50 = SizedBox(
    width: 50,
    height: 50,
  );
  static const shape_60 = SizedBox(
    width: 60,
    height: 60,
  );
  static const shape_80 = SizedBox(
    width: 80,
    height: 80,
  );

  static getCustomBoxShape(double size) => SizedBox(
        width: size,
        height: size,
      );

  static getCustomShape(double cWidth, double cHeight) => SizedBox(
        width: cWidth,
        height: cHeight,
      );
}
