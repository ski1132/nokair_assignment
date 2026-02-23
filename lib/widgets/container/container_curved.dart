import 'package:flutter/material.dart';

class ContainerCurved extends StatelessWidget {
  final double? width;
  final double? height;
  final Function()? onTap;
  final Color borderColor;
  final Color backgroundColor;
  final Gradient? gradient;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadiusGeometry? borderRadius;
  final DecorationImage? backgroundImage;
  final List<BoxShadow>? boxShadow;
  final Widget child;
  const ContainerCurved({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius,
    this.backgroundImage,
    this.boxShadow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: gradient == null ? backgroundColor : null,
          gradient: gradient,
          image: backgroundImage,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
