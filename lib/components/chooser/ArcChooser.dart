import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'ChooserPainter.dart';

class ArcItem {
  String text;
  List<Color> colors;
  double startAngle;

  ArcItem(this.text, this.colors, this.startAngle);
}

class ArcChooser extends StatefulWidget {
  final Function arcSelectedCallback;
  final List<String> arcNames;
  ArcChooser({Key key, this.arcNames, this.arcSelectedCallback}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChooserState();
  }
}

class ChooserState extends State<ArcChooser> with SingleTickerProviderStateMixin {
  var slideValue = 0;
  Offset centerPoint;

  double userAngle = 0.0;
  double startAngle;

  static double center = 280.0;
  static double centerInRadians = degreeToRadians(center);
  static double angle = 45.0;

  static double angleInRadians = degreeToRadians(angle);
  static double angleInRadiansByTwo = angleInRadians / 2;
  static double centerItemAngle = degreeToRadians(center - (angle / 2));

  List<ArcItem> arcItems = List<ArcItem>();

  AnimationController animation;
  double animationStart;
  double animationEnd = 0.0;

  int currentPosition = 5;

  Offset startingPoint;
  Offset endingPoint;

  Function arcSelectedCallback;

  static double degreeToRadians(double degree) {
    return degree * (pi / 180);
  }

  static double radianToDegrees(double radian) {
    return radian * (180 / pi);
  }

  @override
  void initState() {
    arcSelectedCallback = widget.arcSelectedCallback;

    animation = new AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    animation.addListener(() {
      userAngle = lerpDouble(animationStart, animationEnd, animation.value);
      setState(() {
        for (int i = 0; i < arcItems.length; i++) {
          arcItems[i].startAngle = angleInRadiansByTwo + userAngle + (i * angleInRadians);
        }
      });
    });
    super.initState();
  }

  void buildArcItems(List<String> arcNames) {
    arcItems = List<ArcItem>();
    
    if (arcNames == null && arcNames.length < 8) {
      return;
    }
    arcItems.add(ArcItem(arcNames[0], [Color(0xFFF9D976), Color(0xfff39f86)], angleInRadiansByTwo + userAngle));
    arcItems.add(ArcItem(
        arcNames[1], [Color(0xFF21e1fa), Color(0xff3bb8fd)], angleInRadiansByTwo + userAngle + (angleInRadians)));
    arcItems.add(ArcItem(
        arcNames[2], [Color(0xFF3ee98a), Color(0xFF41f7c7)], angleInRadiansByTwo + userAngle + (2 * angleInRadians)));
    arcItems.add(ArcItem(
        arcNames[3], [Color(0xFFfe0944), Color(0xFFfeae96)], angleInRadiansByTwo + userAngle + (3 * angleInRadians)));
    arcItems.add(ArcItem(
        arcNames[4], [Color(0xFFF9D976), Color(0xfff39f86)], angleInRadiansByTwo + userAngle + (4 * angleInRadians)));
    arcItems.add(ArcItem(
        arcNames[5], [Color(0xFF21e1fa), Color(0xff3bb8fd)], angleInRadiansByTwo + userAngle + (5 * angleInRadians)));
    arcItems.add(ArcItem(
        arcNames[6], [Color(0xFF3ee98a), Color(0xFF41f7c7)], angleInRadiansByTwo + userAngle + (6 * angleInRadians)));
    arcItems.add(ArcItem(
        arcNames[7], [Color(0xFFfe0944), Color(0xFFfeae96)], angleInRadiansByTwo + userAngle + (7 * angleInRadians)));
  }

  @override
  Widget build(BuildContext context) {
    double centerX = MediaQuery.of(context).size.width / 2;
    double centerY = MediaQuery.of(context).size.height * 1.5;
    centerPoint = Offset(centerX, centerY);
    buildArcItems(widget.arcNames);

    return GestureDetector(
      onTap: () {
        if (widget.arcSelectedCallback == null) {
          return;
        }
        widget.arcSelectedCallback(currentPosition);
      },
      onPanStart: (DragStartDetails details) {
        startingPoint = details.globalPosition;
        var deltaX = centerPoint.dx - details.globalPosition.dx;
        var deltaY = centerPoint.dy - details.globalPosition.dy;
        startAngle = atan2(deltaY, deltaX);
      },
      onPanUpdate: (DragUpdateDetails details) {
        endingPoint = details.globalPosition;
        var deltaX = centerPoint.dx - details.globalPosition.dx;
        var deltaY = centerPoint.dy - details.globalPosition.dy;
        var freshAngle = atan2(deltaY, deltaX);
        userAngle += freshAngle - startAngle;
        setState(() {
          for (int i = 0; i < arcItems.length; i++) {
            arcItems[i].startAngle = angleInRadiansByTwo + userAngle + (i * angleInRadians);
          }
        });
        startAngle = freshAngle;
      },
      onPanEnd: (DragEndDetails details) {
        bool rightToLeft = startingPoint.dx < endingPoint.dx;

        animationStart = userAngle;
        if (rightToLeft) {
          animationEnd += angleInRadians;
          currentPosition--;
          if (currentPosition < 0) {
            currentPosition = arcItems.length - 1;
          }
        } else {
          animationEnd -= angleInRadians;
          currentPosition++;
          if (currentPosition >= arcItems.length) {
            currentPosition = 0;
          }
        }

        animation.forward(from: 0.0);
      },
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width * 1 / 1.5),
        painter: ChooserPainter(arcItems, angleInRadians),
      ),
    );
  }
}