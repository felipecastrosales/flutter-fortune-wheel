import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/src/helpers/helpers.dart';
import 'package:flutter_fortune_wheel/src/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';

///UI Wheel
class BoardView extends StatelessWidget {
  const BoardView({
    Key? key,
    required this.items,
    required this.size,
    required this.onTapWheel,
  }) : super(key: key);

  ///List of values for the wheel elements
  final List<Fortune> items;

  ///Size of the wheel
  final double size;

  ///Handling when tapping on the wheel
  final VoidCallback onTapWheel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(
          items.length,
          (index) => _buildSlicedCircle(items[index]),
        ),
      ),
    );
  }

  Widget _buildSlicedCircle(Fortune fortune) {
    double _rotate = getRotateOfItem(
      items.length,
      items.indexOf(fortune),
    );
    return InkWell(
      onTap: onTapWheel,
      child: Transform.rotate(
        angle: _rotate,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildCard(fortune),
            _buildValue(fortune),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Fortune fortune) {
    double _angle = 2 * math.pi / items.length;
    return ClipPath(
      clipper: _SlicesPath(_angle),
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: fortune.backgroundColor,
          gradient: fortune.backgroundColors != null
              ? LinearGradient(
                  colors: fortune.backgroundColors!,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildValue(Fortune fortune) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: size / 3, width: size - 32),
        child: Transform.rotate(
          angle: -45,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (fortune.imageUrl != null) ...[
                Flexible(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.network(
                      fortune.imageUrl!,
                      fit: BoxFit.contain,
                      height: fortune.imageSize,
                      width: fortune.imageSize,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (fortune.titleName != null)
                Flexible(
                  child: AutoSizeText(
                    fortune.titleName!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    maxFontSize: 20,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    style: fortune.textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              if (fortune.icon != null)
                Padding(
                  padding: EdgeInsets.all(fortune.titleName != null ? 8 : 0),
                  child: fortune.icon!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlicesPath extends CustomClipper<Path> {
  final double angle;

  _SlicesPath(this.angle);

  @override
  Path getClip(Size size) {
    Offset center = size.center(Offset.zero);
    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);
    Path path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, -math.pi / 2 - angle / 2, angle, false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_SlicesPath oldClipper) {
    return angle != oldClipper.angle;
  }
}
