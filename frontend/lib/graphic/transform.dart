import 'dart:math' as math;

import 'package:flutter/material.dart';


double deg(double angle) => angle * math.pi / 180;

class Rotate extends StatefulWidget {
  final Widget child;
  final double angle;
  const Rotate({super.key , required this.child , required this.angle});

  @override
  State<Rotate> createState() => _RotateState();
}

class _RotateState extends State<Rotate> {
  @override
  Widget build(BuildContext context) {
    final Widget child = widget.child;
    final double angle = widget.angle;
    return Transform.rotate(
      angle : deg(angle),
      child : child
    );
  }
}