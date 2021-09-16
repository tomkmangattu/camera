import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppIcon extends CustomPainter {
  final double s;

  const MyAppIcon({
    required this.s,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWith = s * 3 / 100;

    final greenLine = Paint()
      ..color = color2
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWith
      ..strokeCap = StrokeCap.round;

    final blackLine = Paint()
      ..color = color1
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWith
      ..strokeCap = StrokeCap.round;

    final radius = Radius.circular(s / 20);

    // center green line
    final p1 = Offset(s / 10, s / 2);
    final p2 = Offset(s * 9 / 10, s / 2);
    canvas.drawLine(p1, p2, greenLine);

    // square top part
    final logo = Path();
    logo.moveTo(s / 10, s / 3);
    logo.lineTo(s / 10, s / 10);
    logo.lineTo(s * 9 / 10, s / 10);
    logo.lineTo(s * 9 / 10, s / 3);

    // square bottom part
    logo.moveTo(s / 10, s * 2 / 3);
    logo.lineTo(s / 10, s * 9 / 10);
    logo.lineTo(s * 9 / 10, s * 9 / 10);
    logo.lineTo(s * 9 / 10, s * 2 / 3);

    // side bent top left
    logo.moveTo(s / 20, s / 5);
    logo.lineTo(s / 20, s / 10);
    logo.arcToPoint(
      Offset(s / 10, s / 20),
      radius: radius,
    );
    logo.lineTo(s / 5, s / 20);

    // side bent top right
    logo.moveTo(s * 4 / 5, s / 20);
    logo.lineTo(s * 9 / 10, s / 20);
    logo.arcToPoint(
      Offset(s * 19 / 20, s / 10),
      radius: radius,
    );
    logo.lineTo(s * 19 / 20, s / 5);

    //side bent bottom right
    logo.moveTo(s * 19 / 20, s * 4 / 5);
    logo.lineTo(s * 19 / 20, s * 9 / 10);
    logo.arcToPoint(
      Offset(s * 9 / 10, s * 19 / 20),
      radius: radius,
    );
    logo.lineTo(s * 4 / 5, s * 19 / 20);

    //side bent bottom left
    logo.moveTo(s / 5, s * 19 / 20);
    logo.lineTo(s / 10, s * 19 / 20);
    logo.arcToPoint(
      Offset(s / 20, s * 9 / 10),
      radius: radius,
    );
    logo.lineTo(s / 20, s * 4 / 5);

    canvas.drawPath(logo, blackLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

const color1 = Color(0xFF393a3a);
const color2 = Color(0xFF1dAA44);
