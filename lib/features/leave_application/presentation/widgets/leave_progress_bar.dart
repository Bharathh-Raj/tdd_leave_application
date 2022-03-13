import 'package:flutter/material.dart';

class LeaveProgressBar extends StatelessWidget {
  final int currentLeaveCount;
  final int maxLeaveCount;
  const LeaveProgressBar({
    Key? key,
    required this.currentLeaveCount,
    required this.maxLeaveCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$currentLeaveCount Leave',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              '$maxLeaveCount Leaves',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 6,
          child: SizedBox.expand(
            child: CustomPaint(
              painter: LeaveProgressBarPainter(currentLeaveCount / maxLeaveCount),
            ),
          ),
        ),
      ],
    );
  }
}

class LeaveProgressBarPainter extends CustomPainter {
  final double leaveFraction;

  LeaveProgressBarPainter(this.leaveFraction);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
    canvas.drawLine(
        Offset.zero, Offset(size.width * leaveFraction, 0), paint..color = const Color(0xffFFD34B));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
