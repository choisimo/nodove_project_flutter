import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:nodove_flutter/state/color.dart';

class TooltipShape extends ShapeBorder {
  final double? verticalOffset;
  final double radius = 16;
  final double triSize = 10;
  final double kborder = 1;
  final Color? borderColor;

  const TooltipShape(this.verticalOffset , this.borderColor);

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
    final Path path = Path();
    final double offset = verticalOffset??125;
    
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);
    final Map<String,double> radiusAuto = {
      "left" : 
      (rrect.width - (offset + triSize * 2) < radius && rrect.width > offset)?
      rrect.width - (offset + triSize * 2)
      :radius,
      "right" : 
      ((offset) < radius && rrect.width > offset)?
      offset
      :radius
    };

    path.moveTo(0, radiusAuto['left']!);
    path.quadraticBezierTo(0, 0, radiusAuto['left']!, 0);
    path.lineTo(rrect.width - (offset + triSize * 2), 0);
    path.lineTo(rrect.width - (offset + triSize), -1 * triSize);
    path.lineTo(rrect.width - offset, 0);
    path.lineTo(rrect.width - radiusAuto['right']!, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, radiusAuto['right']!);
    path.lineTo(rrect.width, rrect.height - radius);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - radius, rrect.height);
    path.lineTo(radius, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - radius);
    path.lineTo(0, radiusAuto['left']!);

    return path;
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect,
    {TextDirection? textDirection}) {
      final rrectShadow = RRect.fromRectAndRadius(rect, Radius.circular(radius));
      final shadowPaint = Paint()
        ..strokeWidth = 0.5
        ..color = borderColor??CommonStyle.firstAlpha
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

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