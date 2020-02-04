import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'ArcChooser.dart';

// draw the arc and other stuff
class ChooserPainter extends CustomPainter {
  //debugging Paint
  final debugPaint = Paint()
    ..color = Colors.red.withAlpha(100) //0xFFF9D976
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  final linePaint = Paint()
    ..color = Colors.black.withAlpha(65) //0xFFF9D976
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.square;

  final whitePaint = Paint()
    ..color = Colors.indigoAccent
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  List<ArcItem> arcItems;
  double angleInRadians;
  double angleInRadiansByTwo;
  double angleInRadians1;
  double angleInRadians2;
  double angleInRadians3;
  double angleInRadians4;

  ChooserPainter(List<ArcItem> arcItems, double angleInRadians) {
    this.arcItems = arcItems;
    this.angleInRadians = angleInRadians;
    this.angleInRadiansByTwo = angleInRadians / 2;

    angleInRadians1 = angleInRadians / 6;
    angleInRadians2 = angleInRadians / 3;
    angleInRadians3 = angleInRadians * 4 / 6;
    angleInRadians4 = angleInRadians * 5 / 6;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height * 1.6;
    Offset center = Offset(centerX, centerY);
    //double radius = sqrt((size.width * size.width) / 2);
    double radius = sqrt((size.width * (size.width / 2)) / 2);

    //for white arc at bottom
    double leftX = centerX - radius;
    double topY = centerY - radius;
    double rightX = centerX + radius;
    double bottomY = centerY + radius;

    //for items
    double radiusItems = radius * 1.5;
    double leftX2 = centerX - radiusItems;
    double topY2 = centerY - radiusItems;
    double rightX2 = centerX + radiusItems;
    double bottomY2 = centerY + radiusItems;

    double radiusText = radius * 1.35;
    var arcRect = Rect.fromLTRB(leftX2, topY2, rightX2, bottomY2);
    var dummyRect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    canvas.clipRect(dummyRect, clipOp: ClipOp.intersect);

    for (int i = 0; i < arcItems.length; i++) {
      canvas.drawArc(
          arcRect,
          arcItems[i].startAngle,
          angleInRadians,
          true,
          Paint()
            ..style = PaintingStyle.fill
            ..shader = LinearGradient(
              colors: arcItems[i].colors,
            ).createShader(dummyRect));

      //draw text
      TextSpan span = TextSpan(
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: arcItems[i].text.length > 20 ? 18 : 20.0,
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.normal,
              color: Colors.white),
          text: arcItems[i].text);
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();

      //center text
      double f = tp.width / 2;

      if (arcItems[i].text.contains('\n')) {
        radiusText = radius * 1.40;
      } else {
        radiusText = radius * 1.35;
      }

      double t = sqrt((radiusText * radiusText) + (f * f));

      double additionalAngle = acos(((t * t) + (radiusText * radiusText) - (f * f)) / (2 * t * radiusText));

      double tX = center.dx + radiusText * cos(arcItems[i].startAngle + angleInRadiansByTwo - additionalAngle);
      double tY = center.dy + radiusText * sin(arcItems[i].startAngle + angleInRadiansByTwo - additionalAngle);

      canvas.save();
      canvas.translate(tX, tY);
      canvas.rotate(arcItems[i].startAngle + angleInRadians + angleInRadians + angleInRadiansByTwo);
      tp.paint(canvas, Offset(0.0, 0.0));
      canvas.restore();
    }

    //bottom white arc
    canvas.drawArc(Rect.fromLTRB(leftX, topY, rightX, bottomY), ChooserState.degreeToRadians(180.0),
        ChooserState.degreeToRadians(180.0), true, whitePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
