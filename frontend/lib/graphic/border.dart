import 'package:flutter/material.dart';
import 'dart:math' as math;

class TooltipShape extends ShapeBorder {
  final double? verticalOffset;
  final double radius = 16;
  final double triSize = 10;

  const TooltipShape(this.verticalOffset);

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

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(rrect.width - (offset + triSize * 2), 0);
    path.lineTo(rrect.width - (offset + triSize), -1 * triSize);
    path.lineTo(rrect.width - offset, 0);
    path.lineTo(rrect.width - radius, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, radius);
    path.lineTo(rrect.width, rrect.height - radius);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - radius, rrect.height);
    path.lineTo(radius, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - radius);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
  );
}