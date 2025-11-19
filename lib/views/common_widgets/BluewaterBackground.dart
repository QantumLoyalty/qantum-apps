import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/utils/AppColors.dart';

class BluewaterBackground extends StatelessWidget {
  const BluewaterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -60,
      bottom: 0,
      child: Transform.rotate(
        angle: 340 * math.pi / 180,
        child: Image.asset(
          "assets/bluewaterCaptainsClub/captains_cap.png",
          width: 250,
          height: 250,
          color: AppColors.white.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
