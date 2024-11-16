import 'package:flutter/material.dart';

class CirclePaint extends StatelessWidget {
  const CirclePaint({
    super.key,
    this.circleColor,
  });

  final Color? circleColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        circleColor: circleColor,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    Color? circleColor,
  }) : circleColor = circleColor ?? const Color.fromARGB(255, 50, 50, 50);

  final Color circleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final paint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
