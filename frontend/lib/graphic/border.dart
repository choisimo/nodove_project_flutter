
import 'package:flutter/material.dart';
import 'dart:math' as math;


class TooltipShape extends ShapeBorder {
  final double vertical;
  final double horizontal;
  final String direction;
  final double rRadius;
  final double triSize;
  final Color borderColor;

  const TooltipShape({
    this.vertical = 125,
    this.horizontal = 125,
    this.direction = "top",
    this.borderColor = Colors.black,
    this.rRadius = 16,
    this.triSize = 10
  });

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);
    final double vOffset = math.min(vertical,rrect.width - triSize);
    final double hOffset = math.min(horizontal,rrect.width - triSize);
    
    switch(direction){
      case 'bottom' : return 
      tooltipBottomSidePath(
        rrect,
        speechBubble(
          radius: rRadius,
          offset : vOffset,
          triSize: triSize,
        )
      );
      default : return 
      tooltipTopSidePath(
        rrect,
        speechBubble(
          radius: rRadius,
          offset : vOffset,
          triSize: triSize,
        )
      );
    }
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect,
    {TextDirection? textDirection}) {
    final shadowPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 6);
    
    canvas.drawPath(
      getOuterPath(rect),
      shadowPaint
    );
  }

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
  );
}

class speechBubble {
  double offset;
  double triSize;
  double radius;

  speechBubble({
    this.offset = 0.0,
    this.triSize = 0.0,
    this.radius = 0.0,
  });
}

Path tooltipTopSidePath(rrect,speechBubble bubble) {
  final Map<String,double> radiusAuto = {
    "left" : 
    (rrect.width - (bubble.offset + bubble.triSize * 2) < bubble.radius && rrect.width > bubble.offset)?
    rrect.width - (bubble.offset + bubble.triSize * 2)
    :bubble.radius,
    "right" : 
    ((bubble.offset) < bubble.radius && rrect.width > bubble.offset)?
    bubble.offset
    :bubble.radius
  };
  return Path()
    ..moveTo(0, radiusAuto['left']!)
    ..quadraticBezierTo(0, 0, radiusAuto['left']!, 0)
    
    ..lineTo(rrect.width - (bubble.offset + bubble.triSize * 2), 0)
    ..quadraticBezierTo(rrect.width - bubble.offset - bubble.triSize*2, -0.5 * bubble.triSize,rrect.width - (bubble.offset + bubble.triSize), -1 * bubble.triSize)
    ..quadraticBezierTo(rrect.width - bubble.offset - bubble.triSize, -0.5 * bubble.triSize,rrect.width - bubble.offset, 0)

    ..lineTo(rrect.width - radiusAuto['right']!, 0)
    ..quadraticBezierTo(rrect.width, 0, rrect.width,bubble.radius)
    ..lineTo(rrect.width, rrect.height - bubble.radius)
    ..quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - bubble.radius, rrect.height)
    ..lineTo(bubble.radius, rrect.height)
    ..quadraticBezierTo(0, rrect.height, 0, rrect.height - bubble.radius)
    ..lineTo(0, radiusAuto['left']!);
}

Path tooltipBottomSidePath(rrect,speechBubble bubble) {
  final Map<String,double> radiusAuto = {
    "left" : 
    (rrect.width - (bubble.offset + bubble.triSize * 2) < bubble.radius && rrect.width > bubble.offset)?
    rrect.width - (bubble.offset + bubble.triSize * 2)
    :bubble.radius,
    "right" : 
    ((bubble.offset) < bubble.radius && rrect.width > bubble.offset)?
    bubble.offset
    :bubble.radius
  };
  return Path()
    ..moveTo(0, bubble.radius)
    ..quadraticBezierTo(0, 0, bubble.radius, 0)
    ..lineTo(rrect.width - bubble.radius, 0)
    ..quadraticBezierTo(rrect.width, 0, rrect.width, bubble.radius)
    ..lineTo(rrect.width, rrect.height - bubble.radius)
    ..quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - radiusAuto['left']!, rrect.height)
    ..lineTo((bubble.offset + bubble.triSize * 2), rrect.height)

    ..quadraticBezierTo(
        (bubble.offset + bubble.triSize), rrect.height + bubble.triSize * 0.5, (bubble.offset + bubble.triSize), rrect.height + bubble.triSize)
    ..quadraticBezierTo(
        (bubble.offset), rrect.height + bubble.triSize * 0.5, bubble.offset, rrect.height)
    
    ..lineTo(radiusAuto['right']!, rrect.height)
    ..quadraticBezierTo(0, rrect.height, 0, rrect.height - bubble.radius)
    ..lineTo(0, bubble.radius);
}