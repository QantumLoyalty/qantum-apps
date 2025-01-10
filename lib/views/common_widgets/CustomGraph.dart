import 'package:flutter/material.dart';

class CustomGraph extends StatelessWidget {
  const CustomGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: MapGraph(),
    );
  }
}

class MapGraph extends CustomPainter {
  List<Offset> points = [
    Offset(50, 50),
    Offset(100, 100),
    Offset(150, 50),
    Offset(200, 200),
    Offset(250, 150),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var point in points) {
      canvas.drawCircle(point, 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
