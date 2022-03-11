import 'package:flutter/material.dart';

class BGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader =
          const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        Color(0xff5C91F9),
        Color(0xff0065FF),
      ]).createShader(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    canvas.drawRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), bgPaint);

    Paint circlePaint = Paint()..color = const Color(0xff5C91F9).withOpacity(0.25);
    canvas.drawCircle(Offset(size.width - 60, 20), 150, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
