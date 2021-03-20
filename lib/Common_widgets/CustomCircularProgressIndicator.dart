import 'package:flutter/material.dart';
import 'dart:math';

class CustomProgressIndicator extends StatefulWidget {
  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with TickerProviderStateMixin {
  AnimationController rotationController;
  @override
  void initState() {
    rotationController = AnimationController(
      duration: Duration(seconds: 10),
      upperBound: pi * 2,
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: rotationController,
      builder: (_, child) {
        return Transform.rotate(
          angle: rotationController.value * 2 * pi,
          child: child,
        );
      },
      child: Container(
        height: 75,
        child: Image.asset(
          "assets/amalgam_logo.png",
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
