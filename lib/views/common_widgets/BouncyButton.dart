import 'package:flutter/material.dart';

class BouncyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double shrinkScale; // How much it shrinks (0.95 means it shrinks by 5%)

  const BouncyButton({
    super.key,
    required this.child,
    required this.onTap,
    this.shrinkScale = 0.95,
  });

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      // Speed of the shrink phase
      lowerBound: widget.shrinkScale,
      // Shrink target scale
      upperBound: 1.0,
      // Normal size scale
      value: 1.0, // Starting value
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse(); // Shrinks the button down
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward(); // Springs it back up to normal size
  }

  void _onTapCancel() {
    _controller
        .forward(); // Springs back up if the user drags their finger away
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _controller,
          child: widget.child,
        ),
      ),
    );
  }
}
