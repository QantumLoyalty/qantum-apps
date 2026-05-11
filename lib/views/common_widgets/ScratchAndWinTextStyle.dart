import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ScratchAndWinTextStyle extends StatelessWidget {
  final List<ScratchWinLine> lines;
  final double skewX;

  const ScratchAndWinTextStyle({
    super.key,
    required this.lines,
    this.skewX = -0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.skewX(skewX), // slight italic slant like the logo
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*      _StrokedGradientText(text: 'SCRATCH', fontSize: 54),
          _StrokedGradientText(text: 'AND', fontSize: 28),
          _StrokedGradientText(text: 'WIN!', fontSize: 60),*/

            for (int i = 0; i < lines.length; i++) ...[
              _StrokedGradientText(
                text: lines[i].text,
                fontSize: lines[i].fontSize,
              ),
              if (i < lines.length - 1) SizedBox(height: lines[i].spacingAfter)
            ]
          ],
        ));
  }
}

class _StrokedGradientText extends StatelessWidget {
  final String text;
  final double fontSize;

  const _StrokedGradientText({required this.text, required this.fontSize});

  Size _measureText() {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Add padding on both sides to account for stroke overflow
    return Size(tp.width + 40, tp.height + 5);
  }

  @override
  Widget build(BuildContext context) {
    final size = _measureText();
    return CustomPaint(
      painter: _MultiLayerTextPainter(text: text, fontSize: fontSize),
      size: size,
    );
  }
}

class _MultiLayerTextPainter extends CustomPainter {
  final String text;
  final double fontSize;

  _MultiLayerTextPainter({required this.text, required this.fontSize});

  void _drawText(Canvas canvas, Size size, Paint paint) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          foreground: paint,
          letterSpacing: 3,
          height: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(); // No minWidth/maxWidth constraint — let it be natural width

    // Center within the padded canvas
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // ── Layer 1: Dark navy outermost stroke (shadow/depth) ──
    /*_drawText(
      canvas, size,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 28
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0xFF0A0520),
    );*/

    // ── Layer 2: Deep purple outer glow stroke ──
    _drawText(
      canvas,
      size,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0xFF2D0E6E),
    );

    // ── Layer 3: Bright purple outline ──
    _drawText(
      canvas,
      size,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0xFF5B2BC2),
    );

    // ── Layer 4: Dark orange under-glow (gives depth to gold) ──
    _drawText(
      canvas,
      size,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0xFFBF4D00),
    );

    // ── Layer 5: Gold gradient FILL ──
    _drawText(
      canvas,
      size,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(0, 0),
          Offset(0, size.height),
          const [
            Color(0xFFFFFDE0), // bright white-yellow top highlight
            Color(0xFFFFE44D), // bright gold
            Color(0xFFFFB800), // mid gold
            Color(0xFFFF8200), // deep orange-gold
            Color(0xFFCC5500), // burnt orange at bottom
          ],
          [0.0, 0.2, 0.55, 0.8, 1.0],
        ),
    );

    // ── Layer 6: White shine overlay on top portion only ──
    _drawText(
      canvas,
      size,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(0, 0),
          Offset(0, size.height * 0.45),
          const [
            Color(0x99FFFFFF), // semi-transparent white
            Color(0x00FFFFFF), // fade to transparent
          ],
          [0.0, 1.0],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ScratchWinLine {
  final String text;
  final double fontSize;
  final double spacingAfter;

  const ScratchWinLine({
    required this.text,
    required this.fontSize,
    this.spacingAfter = 0,
  });
}
