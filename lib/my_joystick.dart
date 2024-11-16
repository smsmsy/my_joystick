import 'package:flutter/material.dart';
import 'package:my_joystick/base_paint.dart';
import 'package:my_joystick/circle_paint.dart';
import 'package:my_joystick/extension.dart';

class MyJoystick extends StatefulWidget {
  const MyJoystick({
    super.key,
    this.size = Size.infinite,
    required this.onMove,
    this.baseColor,
    this.arrowColor,
    this.circleColor,
  });

  final Size size;
  final Function(JoystickMove) onMove;

  final Color? baseColor;
  final Color? arrowColor;
  final Color? circleColor;

  @override
  State<MyJoystick> createState() => _MyJoystickState();
}

class _MyJoystickState extends State<MyJoystick> {
  late final Size baseSize;
  late final Size circleSize;

  late Offset circleOffset;

  @override
  void initState() {
    super.initState();
    baseSize = Size(widget.size.shortestSide, widget.size.shortestSide);
    circleSize = baseSize.resizeWith(1 / 4);
    circleOffset = Offset(baseSize.width, baseSize.width) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Stack(
        children: [
          SizedBox.fromSize(
            size: baseSize,
            child: BasePaint(
              baseColor: widget.baseColor,
              arrowColor: widget.arrowColor,
            ),
          ),
          Positioned(
            top: circleOffset.dy,
            left: circleOffset.dx,
            child: SizedBox.fromSize(
              size: circleSize,
              child: CirclePaint(
                circleColor: widget.circleColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final moveOffset =
        details.localPosition - Offset(baseSize.width, baseSize.width) / 2;
    final maxRadius = (baseSize.width - circleSize.width) / 2;
    final limitedOffset = Offset.fromDirection(
      moveOffset.direction,
      moveOffset.distance.clamp(0, maxRadius),
    );
    setState(() {
      circleOffset = Offset(baseSize.width, baseSize.width) / 2 + limitedOffset;
    });
    widget.onMove(
      JoystickMove(
        x: limitedOffset.dx / maxRadius,
        y: limitedOffset.dy / maxRadius,
      ),
    );
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      circleOffset = Offset(baseSize.width, baseSize.width) / 2;
    });
  }
}

class JoystickMove {
  JoystickMove({
    required this.x,
    required this.y,
  });

  final double x;
  final double y;

  @override
  String toString() {
    return 'JoystickMove(x: $x, y: $y)';
  }
}
