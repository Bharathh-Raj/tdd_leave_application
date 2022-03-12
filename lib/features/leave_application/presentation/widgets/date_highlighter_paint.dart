import 'package:flutter/material.dart';

class DateHighlighterPaint extends CustomPainter {
  final bool isToDateNull;
  final bool paintTowardsRight;

  DateHighlighterPaint({required this.isToDateNull, this.paintTowardsRight = true});
  @override
  void paint(Canvas canvas, Size size) {
    Paint pointerPaint = Paint()..color = Colors.white.withOpacity(0.25);
    Paint circlePaint = Paint()..color = Colors.white;

    if (!isToDateNull) {
      canvas.drawRect(
          Rect.fromPoints(paintTowardsRight ? Offset(size.width, 0) : Offset.zero,
              Offset(size.width / 2, size.height)),
          pointerPaint);
    }
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.height / 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
