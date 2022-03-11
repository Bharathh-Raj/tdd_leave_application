import 'package:flutter/material.dart';
import 'package:leave_application/core/constants/color_constants.dart';

class BGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader =
          const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        ColorConstants.primaryColorVariant,
        ColorConstants.primaryColor,
      ]).createShader(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    canvas.drawRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), bgPaint);

    Paint circlePaint = Paint()..color = ColorConstants.primaryColorVariant.withOpacity(0.25);
    canvas.drawCircle(Offset(size.width - 60, 20), 150, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
