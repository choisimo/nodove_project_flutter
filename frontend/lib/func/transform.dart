import 'dart:math' as math;

import 'package:flutter/material.dart';


double deg(double angle) => angle * math.pi / 180;

class Rotate extends StatelessWidget {
  final Widget child;
  final double angle;
  const Rotate({super.key , required this.child , required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle : deg(angle),
      child : child
    );
  }
}