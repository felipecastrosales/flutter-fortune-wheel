import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Lucky Wheel Element Value
@immutable
class Fortune extends Equatable {
  const Fortune({
    required this.id,
    this.titleName,
    this.imageUrl,
    this.imageSize = 50,
    this.backgroundColor,
    this.priority = 1,
    this.icon,
    this.textStyle,
    this.backgroundColors,
  })  : assert(priority >= 0),
        assert(backgroundColors != null || backgroundColor != null),
        assert(backgroundColors == null || backgroundColors.length >= 2),
        assert(titleName != null || icon != null);

  ///Lucky Value ID
  final int id;

  ///Lucky value title
  final String? titleName;

  ///Lucky value image
  final String? imageUrl;

  /// Size of the image
  final double imageSize;

  ///Background color Lucky value title
  final Color? backgroundColor;

  /// Backgrounds colors Lucky value title
  final List<Color>? backgroundColors;

  ///Priority spin coefficient
  ///Default value [priority] = 1
  final int priority;

  ///Icon Lucky value
  final Widget? icon;

  ///text style of Lucky value title
  final TextStyle? textStyle;

  @override
  List<Object?> get props => [id, titleName, priority, backgroundColor, icon];

  Fortune copyWith({
    String? titleName,
    Color? backgroundColor,
    int? priority,
    Widget? icon,
    TextStyle? textStyle,
    List<Color>? backgroundColors,
  }) {
    return Fortune(
      id: id,
      titleName: titleName ?? this.titleName,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      priority: priority ?? this.priority,
      icon: icon ?? this.icon,
      textStyle: textStyle ?? this.textStyle,
      backgroundColors: backgroundColors ?? this.backgroundColors,
    );
  }
}
