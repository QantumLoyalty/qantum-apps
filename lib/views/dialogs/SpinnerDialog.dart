import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/AppColors.dart';

class SpinnerDialog extends StatefulWidget {
  const SpinnerDialog({super.key});

  @override
  State<SpinnerDialog> createState() => _SpinnerDialogState();
}

class ArcTextWithBgPainter extends CustomPainter {
  final String text;
  final double radius;
  final TextStyle textStyle;
  final Color backgroundColor;

  ArcTextWithBgPainter({
    required this.text,
    required this.radius,
    required this.textStyle,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final anglePerChar = 2 * 3.141592 / (text.length * 2); // Adjust density
    double startAngle = -anglePerChar * text.length / 2;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final angle = startAngle + i * anglePerChar;

      final dx = center.dx + radius * cos(angle);
      final dy = center.dy + radius * sin(angle);
      final offset = Offset(dx, dy);

      // Background circle or rect
      final bgPaint = Paint()..color = backgroundColor;
      final rect = Rect.fromCenter(center: offset, width: 24, height: 28);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(6)),
        bgPaint,
      );

      // Draw character
      final builder = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle + 3.141592 / 2);
      builder.paint(canvas, Offset(-builder.width / 2, -builder.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _SpinnerDialogState extends State<SpinnerDialog>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _leftRightAnimation;
  late AnimationController _leftRightAnimationController;
  late AnimationController _lottieController;
  StreamController<int> controller = StreamController<int>();
  int index = 0;
  final List<String> items = [
    '200 Coins',
    'Spin Again',
    '1,000 Coins',
    '150,000 Gems',
    'Gift Box',
    'Surprise Box',
    '110 Coins',
    '25,000 Coins',
    'Magic Box',
    '50 Coins',
  ];
  final Map<String, Color> colors = {
    '200 Coins': const Color(0xFF39b8eb),
    'Spin Again': const Color(0xFFffee1a),
    '1,000 Coins': const Color(0xFFa769d0),
    '150,000 Gems': const Color(0xFFfeffdd),
    'Gift Box': const Color(0xFFed2b7e),
    'Surprise Box': const Color(0xFFf3a93e),
    '110 Coins': const Color(0xFFf94536),
    '25,000 Coins': const Color(0xFF36cc87),
    'Magic Box': const Color(0xFF9813e8),
    '50 Coins': const Color(0xFF61e517),
  };

  bool isWheelSpinning = false;
  bool showTapToSpin = true;
  bool spinCompleted = false;

  void spinWheel() async {
    await _rotationController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    final random = Random();
    index = random.nextInt(items.length);
    controller.add(index);
  }

  @override
  void dispose() {
    controller.close();
    _rotationController.dispose();
    _leftRightAnimationController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

    _leftRightAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // repeat the animation

    _leftRightAnimation = Tween<double>(begin: -10.0, end: 10.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_leftRightAnimationController);

    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(
          seconds: 5), // Match this with Lottie animation duration if needed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.70,
          child: Stack(
            children: [
              Positioned(
                top: 40,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFDC7A),
                      border:
                          Border.all(color: const Color(0xFFFFDC7A), width: 10),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/common/spinner_back.png",
                            ),
                            fit: BoxFit.fill),
                        border: Border.all(
                            color: const Color(0xFF885400), width: 10),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Lottie.asset("assets/common/party_pop.json",
                                frameRate: FrameRate.max,
                                controller: _lottieController,
                                onLoaded: (composition) {
                              _lottieController.duration = composition.duration;
                            }),
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 10,
                              height: MediaQuery.of(context).size.width - 10,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.asset(
                                      "assets/common/main_circle_shadow.png",
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: Image.asset(
                                      "assets/common/main_spinner_circle_1.png",
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          170,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              170,
                                      child: InkWell(
                                        onTap: spinWheel,
                                        child: FortuneWheel(
                                          animateFirst: false,
                                          onFling: spinWheel,
                                          duration: const Duration(seconds: 10),
                                          selected: controller.stream,
                                          items: [
                                            for (var item in items)
                                              FortuneItem(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 5),
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                shadows: [
                                                                  Shadow(
                                                                    offset:
                                                                        const Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: AppColors
                                                                        .black
                                                                        .withValues(
                                                                            alpha:
                                                                                0.5),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  style: FortuneItemStyle(
                                                      borderColor:
                                                          Colors.transparent,
                                                      color: colors[item]!)),
                                          ],
                                          indicators: const <FortuneIndicator>[
                                          ],
                                          onAnimationStart: () {
                                            setState(() {
                                              _rotationController.stop();
                                              // showResult = false;
                                              isWheelSpinning = true;
                                              showTapToSpin = false;
                                              spinCompleted = false;
                                            });
                                          },
                                          onAnimationEnd: () {
                                            _lottieController.reset();
                                            _lottieController.forward();

                                            setState(() {
                                              _rotationController.repeat();
                                              isWheelSpinning = false;
                                              showTapToSpin = true;
                                              spinCompleted = true;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 75,
                                      left: 0,
                                      right: 0,
                                      child: Image.asset(
                                        "assets/common/spinner_pointer.png",
                                        width: 30,
                                        height: 42,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: spinWheel,
                              child: CustomPaint(
                                size: Size(
                                    MediaQuery.of(context).size.width - 180,
                                    MediaQuery.of(context).size.width - 155),
                                painter: HollowSectorPainter(
                                    radius: 120,
                                    startAngle: 250,
                                    sweepAngle: 39),
                              ),
                            ),
                          ),
                          Center(
                            child: centerSpinButton(),
                          ),
                          showTapToSpin
                              ? Positioned(
                                  right: -10,
                                  top: 1,
                                  bottom: 1,
                                  child: GestureDetector(
                                    onTap: spinWheel,
                                    child: SizedBox(
                                      width: 150,
                                      height: 28,
                                      child: AnimatedBuilder(
                                        builder: (context, child) =>
                                            Transform.translate(
                                                offset: Offset(
                                                    _leftRightAnimation.value,
                                                    0),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Image.asset(
                                                      "assets/common/left_arrow_spinner.png",
                                                      width: 110,
                                                      height: 40,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const Center(
                                                        child: Text(
                                                      "TAP TO SPIN",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ))
                                                  ],
                                                )),
                                        animation: _leftRightAnimation,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 28,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget centerSpinButton() {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: SizedBox(
              width: 90,
              height: 90,
              child: GestureDetector(
                  onTap: spinWheel,
                  child: Image.asset(
                    "assets/common/spin.png",
                    fit: BoxFit.cover,
                  )),
            ));
      },
      animation: _rotationController,
    );
  }
}

class HollowSectorPainter extends CustomPainter {
  final double startAngle; // in degrees
  final double sweepAngle; // in degrees
  final double radius;
  final double strokeWidth;

  HollowSectorPainter({
    this.startAngle = 0,
    this.sweepAngle = 60,
    this.radius = 100,
    this.strokeWidth = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);

    // Path for the hollow sector
    final Path path = Path();
    final double startRad = radians(startAngle);
    final double sweepRad = radians(sweepAngle);
    final double endRad = startRad + sweepRad;

    final Offset startPoint =
        center + Offset(cos(startRad), sin(startRad)) * radius;
    final Offset endPoint = center + Offset(cos(endRad), sin(endRad)) * radius;

    final Paint radiusShadowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, startPoint, radiusShadowPaint);
    canvas.drawLine(center, endPoint, radiusShadowPaint);

    // --- Draw Actual Radius Lines ---
    final Paint radiusPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, startPoint, radiusPaint);
    canvas.drawLine(center, endPoint, radiusPaint);

    // --- Transparent Arc ---
    final Paint arcPaint = Paint()
      ..blendMode = BlendMode.clear
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()); // Needed for BlendMode.clear

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad,
      false,
      arcPaint,
    );

    canvas.restore();

  }
  double radians(double degrees) => degrees * pi / 180;
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
