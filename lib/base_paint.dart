import 'package:flutter/material.dart';

class BasePaint extends StatelessWidget {
  const BasePaint({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: BasePainter(),
      ),
    );
  }
}

class BasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    assert(size.width == size.height);
    basePaint(canvas, size);
    arrowPaint(canvas, size);
  }

  void basePaint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final paint = Paint()
      ..color = const Color.fromARGB(255, 100, 100, 100)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);

    paint
      ..color = const Color.fromARGB(255, 150, 150, 150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 8 / 2;
    canvas.drawCircle(center, radius * 7 / 8, paint);
  }

  void arrowPaint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 150, 150, 150)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final centerX = size.width * 0.5;
    final centerY = size.height * 0.5;
    final arrowLength = size.width * 0.7;
    final offset = size.width * 0.05;

    final rightArrowPath = Path()
      ..moveTo(centerX + arrowLength / 2 - offset, centerY - offset)
      ..lineTo(centerX + arrowLength / 2, centerY)
      ..lineTo(centerX + arrowLength / 2 - offset, centerY + offset);

    final leftArrowPath = Path()
      ..moveTo(centerX - arrowLength / 2 + offset, centerY - offset)
      ..lineTo(centerX - arrowLength / 2, centerY)
      ..lineTo(centerX - arrowLength / 2 + offset, centerY + offset);

    final upArrowPath = Path()
      ..moveTo(centerX - offset, centerY - arrowLength / 2 + offset)
      ..lineTo(centerX, centerY - arrowLength / 2)
      ..lineTo(centerX + offset, centerY - arrowLength / 2 + offset);

    final downArrowPath = Path()
      ..moveTo(centerX - offset, centerY + arrowLength / 2 - offset)
      ..lineTo(centerX, centerY + arrowLength / 2)
      ..lineTo(centerX + offset, centerY + arrowLength / 2 - offset);

    canvas
      ..drawPath(rightArrowPath, paint)
      ..drawPath(leftArrowPath, paint)
      ..drawPath(upArrowPath, paint)
      ..drawPath(downArrowPath, paint);
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
