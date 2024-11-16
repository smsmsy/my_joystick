import 'package:flutter/material.dart';
import 'package:my_joystick/base_paint.dart';
import 'package:my_joystick/circle_paint.dart';
import 'package:my_joystick/extension.dart';

class MyJoystick extends StatefulWidget {
  const MyJoystick({
    super.key,
    this.size = Size.infinite,
    this.baseWidget,
    this.circleWidget,
  });

  final Size size;
  final Widget? baseWidget;
  final Widget? circleWidget;

  @override
  State<MyJoystick> createState() => _MyJoystickState();
}

class _MyJoystickState extends State<MyJoystick> {
  late final Size baseSize;
  late final Size circleSize;

  late Offset circleOffset;
  late Offset initOffset;

  @override
  void initState() {
    super.initState();
    baseSize = Size(widget.size.shortestSide, widget.size.shortestSide);
    circleSize = baseSize.resizeWith(1 / 4);
    initOffset = Offset(baseSize.width, baseSize.width) / 2;
    circleOffset = initOffset;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: baseSize,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            circleOffset = details.localPosition;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            circleOffset = details.localPosition;
          });
        },
        onPanEnd: (details) {
          setState(() {
            circleOffset = initOffset;
          });
        },
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
      ),
    );
  }
}
