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

  Offset circleOffset = Offset.zero;
  Offset initOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    baseSize = Size(widget.size.shortestSide, widget.size.shortestSide);
    circleSize = baseSize.resizeWith(1 / 4);
  }

  @override
  Widget build(BuildContext context) {
    // print(circleOffset);
    return SizedBox.fromSize(
      size: baseSize,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            initOffset = details.localPosition;
          });
        },
        onPanUpdate: (details) {
          print(details.localPosition);
          setState(() {
            circleOffset = circleOffset + details.localPosition;
          });
        },
        onPanEnd: (details) {
          setState(() {
            circleOffset = Offset.zero;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.baseWidget ?? BasePaint(size: baseSize),
            widget.circleWidget ??
                CirclePaint(size: circleSize, offset: circleOffset),
          ],
        ),
      ),
    );
  }
}
