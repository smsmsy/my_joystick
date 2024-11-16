import 'package:flutter/material.dart';

class CirclePaint extends StatefulWidget {
  const CirclePaint({
    super.key,
    required this.size,
    required this.offset,
  });

  final Size size;
  final Offset offset;

  @override
  State<CirclePaint> createState() => _CirclePaintState();
}

class _CirclePaintState extends State<CirclePaint> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: CustomPaint(
        painter: CirclePainter(offset: widget.offset),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Offset offset;

  CirclePainter({super.repaint, required this.offset});
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
