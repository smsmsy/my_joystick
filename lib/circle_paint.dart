import 'package:flutter/material.dart';

class CirclePaint extends StatefulWidget {
  const CirclePaint({
    super.key,
  });

  @override
  State<CirclePaint> createState() => _CirclePaintState();
}

class _CirclePaintState extends State<CirclePaint> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
