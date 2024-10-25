import 'package:flutter/material.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'dart:math' as math;


class Rrect{
  final double width;
  final double height;

  Rrect({
    required this.width,
    required this.height
  });
}

class CustomClip extends CustomClipper<Path> {
  final double vertical;
  final double horizontal;
  final String direction;
  final double rRadius;
  final double triSize;
  final Color borderColor;

  const CustomClip({
    this.vertical = 125,
    this.horizontal = 125,
    this.direction = "top",
    this.borderColor = Colors.black,
    this.rRadius = 16,
    this.triSize = 10
  });

  @override
  Path getClip(Size size, {TextDirection? textDirection}) {
    final Rrect rrect = Rrect(width : size.width , height : size.height - triSize);
    final double vOffset = math.min(vertical,size.width - triSize);
    final double hOffset = math.min(horizontal,size.width - triSize);
    
    return tooltipBottomSidePath(
        rrect,
        speechBubble(
          radius: rRadius,
          offset : vOffset,
          triSize: triSize,
        )
      );
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}