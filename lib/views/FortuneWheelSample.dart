import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../core/utils/AppColors.dart';

class FortuneWheelSample extends StatefulWidget {
  const FortuneWheelSample({super.key});

  @override
  State<FortuneWheelSample> createState() => _FortuneWheelSampleState();
}

class _FortuneWheelSampleState extends State<FortuneWheelSample>
    with SingleTickerProviderStateMixin {
  StreamController<int> controller = StreamController<int>();
  bool showResult = false;
  bool tapToSpin = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  int index = 0;
  final List<String> items = [
    '200\nCoins',
    'Spin\nAgain',
    '1,000\nCoins',
    '150,000\nGems',
    'Gift\nBox',
    'Surprise\nBox',
    '110\nCoins',
    '25,000\nCoins',
    'Magic\nBox',
    '50\nCoins',
  ];
  final Map<String, Color> colors = {
    '200\nCoins': Colors.red,
    'Spin\nAgain': Colors.green,
    '1,000\nCoins': Colors.blue,
    '150,000\nGems': Colors.cyan,
    'Gift\nBox': Colors.orange,
    'Surprise\nBox': Colors.pink,
    '110\nCoins': Colors.brown,
    '25,000\nCoins': Colors.blueGrey,
    'Magic\nBox': Colors.black,
    '50\nCoins': Colors.indigo,
  };

  void spinWheel() {
    final random = Random();
    index = random.nextInt(items.length);
    controller.add(index);
  }

  @override
  void initState() {
    super.initState();

    // AnimationController for looping
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // repeat the animation

    // Tween to simulate shake (move left and right)
    _animation = Tween<double>(begin: -10.0, end: 10.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller);

    controller.onResume = () {
      print("Started");
    };
    controller.onPause = () {
      print("Paused");
    };
    controller.onListen = () {
      print("Listening...");
      if (controller.isPaused) {
        print("Paused");
      } else if (controller.isClosed) {
        print("Closed");
      }
    };
  }

  @override
  void dispose() {
    _controller.dispose(); // Always dispose your controllers
    controller.close();
    super.dispose();
  }

  double shake(double animation) =>
      2 * (0.5 - (0.5 - Curves.bounceOut.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 20,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFFD700), // Gold
                    Color(0xFFFFD700), // Gold
                    Color(0xFFFFFFFF),
                    Color(0xFFFFA500), // Slight orange tint
                    Color(0xFFFFFF00), // Yellowish highlight
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: "SPIN",
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "\nAND",
                  style: TextStyle(
                      letterSpacing: 4,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "\nWIN",
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ])),
            ),
          ),
          Center(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.width - 50,
                    child: FortuneWheel(
                      animateFirst: false,
                      duration: const Duration(seconds: 10),
                      selected: controller.stream,
                      items: [
                        for (var item in items)
                          FortuneItem(
                              child: Text(item),
                              style: FortuneItemStyle(color: colors[item]!)),
                      ],
                      indicators: const <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.location_on,
                            size: 40,
                            color: Color(0xFFd6b25b),
                          ),
                        )
                      ],
                      onAnimationStart: () {
                        setState(() {
                          showResult = false;
                          tapToSpin = false;
                        });
                      },
                      onAnimationEnd: () async {
                        //var selectedItem = await controller.done;
                        //print("SELECTED ITEM $selectedItem");
                        setState(() {
                          showResult = true;
                          tapToSpin = true;
                        });
                      },
                    ),
                  ),
                ),
                Center(
                    child: RippleAnimation(

                      color: Colors.deepOrange,
                      delay: const Duration(milliseconds: 300),
                      minRadius: 75,
                      maxRadius: 180,
                      ripplesCount: 10,
                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.brown,
                                        child: InkWell(
                      onTap: spinWheel,
                      child: Text(
                        "SPIN",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: AppColors.black.withValues(alpha: 0.5),
                              )
                            ]),
                      ),
                                        ),
                                      ),
                    )),
                tapToSpin && !showResult
                    ? Positioned(
                        right: 1,
                        top: 1,
                        bottom: 1,
                        child: SizedBox(
                          child: AnimatedBuilder(
                            builder: (context, child) => Transform.translate(
                                offset: Offset(_animation.value, 0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      "assets/common/left_arrow_spin.png",
                                      width: 150,
                                      height: 18,
                                      fit: BoxFit.contain,
                                    ),
                                    Center(
                                        child: Text(
                                      "   TAP TO SPIN",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))
                                  ],
                                )),
                            animation: _animation,
                          ),
                          width: 150,
                          height: 18,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: (showResult)
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(color: Colors.yellow, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(5),
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 30, right: 30),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Congratulations you have won ${items[index]}",
                          style: TextStyle(color: Colors.white),
                        )),
                        AppDimens.shape_20,
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.amber)),
                            onPressed: () {
                              setState(() {
                                showResult = false;
                                tapToSpin = true;
                              });
                            },
                            child: Text(
                              "Collect",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
