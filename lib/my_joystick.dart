import 'package:flutter/material.dart';
import 'package:my_joystick/base_paint.dart';
import 'package:my_joystick/circle_paint.dart';
import 'package:my_joystick/extension.dart';

class MyJoystick extends StatefulWidget {
  const MyJoystick(
      {super.key,
      this.size = Size.infinite,
      this.baseWidget,
      this.circleWidget,
      required this.onMove});

  final Size size;
  final Widget? baseWidget;
  final Widget? circleWidget;
  final Function(Offset) onMove;

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
            child: widget.baseWidget ?? const BasePaint(),
          ),
          Positioned(
            top: circleOffset.dy,
            left: circleOffset.dx,
            child: SizedBox.fromSize(
              size: circleSize,
              child: widget.circleWidget ?? const CirclePaint(),
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
    widget.onMove(circleOffset - Offset(baseSize.width, baseSize.width) / 2);
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      circleOffset = Offset(baseSize.width, baseSize.width) / 2;
    });
  }
}

