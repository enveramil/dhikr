import 'package:flutter/material.dart';

import 'dart:math' as math;

class GradientArcProgress extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;
  final double width;

  GradientArcProgress(this.progress, this.startColor, this.endColor, this.width);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = SweepGradient(
      startAngle: 3 * math.pi / 2,
      endAngle: 7 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: [endColor, startColor, endColor],
    );

    final fullCircle = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFdfe8f9)
      ..strokeWidth = width;

    final shadow = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
      ..strokeWidth = width - 4;

    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -math.pi / 2;
    final sweepAngle = -2 * math.pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, 360, false, fullCircle);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle + 1, false, paint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle + 0.09, false, shadow);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
