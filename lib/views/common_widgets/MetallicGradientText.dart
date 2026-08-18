import 'package:flutter/material.dart';

class MetallicGradientText extends StatelessWidget {
  final String text;
  final double fontSize;

  const MetallicGradientText({
    super.key,
    required this.text,
    this.fontSize = 48.0, // Scale this up or down as needed
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // LAYER 1: The Drop Shadow & Outer Gold Border
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            fontFamily: "Impact",
            // Use 'Impact' or a heavy custom rounded font like 'Fredoka One'
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5.0 // Thickness of the gold border
              ..color = const Color(0xFFD4AF37),
            // Metallic Gold
            shadows: const [
              Shadow(
                offset: Offset(3.0, 4.0),
                blurRadius: 2.0,
                color: Color(0xFFE2CFC9), // Soft pinkish-beige drop shadow
              ),
            ],
          ),
        ),

        // LAYER 2: The Multi-Stop Linear Gradient Mask
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Captures the Purple -> Deep Navy -> Violet shifts
              colors: [
                Color(0xFF983794), // Bright top purple
                Color(0xFF631566), // Mid deep purple
                Color(0xFF0F053D), // Ultra dark navy blue bar across center
                Color(0xFF531E6B), // Bottom violet
                Color(0xFF752474), // Bottom edge purple
              ],
              stops: [0.0, 0.42, 0.50, 0.58, 1.0], // Sharp horizons
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              fontFamily: "Impact",
            ),
          ),
        ),
      ],
    );
  }
}