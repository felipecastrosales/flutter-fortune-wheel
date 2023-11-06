import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    super.key,
    this.child,
    required this.colors,
    this.size,
    this.paddingSize = 16.0,
  });

  final Widget? child;
  final List<Color> colors;
  final double? size;
  final double paddingSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(paddingSize),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
