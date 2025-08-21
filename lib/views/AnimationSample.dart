import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimationSample extends StatefulWidget {
  const AnimationSample({super.key});

  @override
  State<AnimationSample> createState() => _AnimationsampleState();
}

class _AnimationsampleState extends State<AnimationSample>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    bool value = false;

                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: value ? 200 : 300,
                              height: value ? 200 : 300,
                              color: value ? Colors.blue : Colors.red,
                              child: const Center(child: Text("Tap Me!")),
                            )),
                      );
                    });
                  });
            },
            child: Text("AnimatedContainer")),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    bool value = false;

                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: value ? 0.0 : 1.0,
                              child: const Center(child: Text("Tap Me!")),
                            )),
                      );
                    });
                  });
            },
            child: Text("AnimatedOpacity")),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    bool value = false;

                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: const Duration(seconds: 1),
                                  alignment: value
                                      ? Alignment.center
                                      : Alignment.topRight,
                                  child: const SizedBox(
                                    child: Text("Tap Me!"),
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ],
                            )),
                      );
                    });
                  });
            },
            child: Text("AnimatedAlign")),
        ElevatedButton(onPressed: () {}, child: Text("AnimatedPositioned")),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    bool value = false;

                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: Stack(
                              children: [
                                AnimatedPadding(
                                  duration: const Duration(seconds: 1),
                                  padding: EdgeInsets.all(value ? 50 : 10),
                                  child: Container(
                                    child: Text("Tap Me!"),
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ],
                            )),
                      );
                    });
                  });
            },
            child: Text("AnimatedPadding")),
        ElevatedButton(onPressed: () {}, child: Text("AnimatedCrossFade")),
        ElevatedButton(onPressed: () {}, child: Text("TweenAnimationBuilder")),
      ],
    );
  }
}
