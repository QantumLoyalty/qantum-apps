import 'package:flutter/material.dart';

extension SpacerExtension on num {
  SizedBox get space => SizedBox(
        width: toDouble(),
        height: toDouble(),
      );

  SizedBox get h => SizedBox(
        height: toDouble(),
      );

  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}
