import 'package:flutter/material.dart';

class FocusPainter extends CustomPainter {
  final double side;

  const FocusPainter({required this.side});

  @override
  void paint(Canvas canvas, Size size) {
    final style = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = side / 50
      ..strokeCap = StrokeCap.round;

    final line = Path();

    // top left
    line.moveTo(0, side / 4);
    line.lineTo(0, 0);
    line.lineTo(side / 4, 0);

    // top right
    line.moveTo(side * 3 / 4, 0);
    line.lineTo(side, 0);
    line.lineTo(side, side / 4);

    // bottom right
    line.moveTo(side, side * 3 / 4);
    line.lineTo(side, side);
    line.lineTo(side * 3 / 4, side);

    // bottom left
    line.moveTo(side / 4, side);
    line.lineTo(0, side);
    line.lineTo(0, side * 3 / 4);

    canvas.drawPath(line, style);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
