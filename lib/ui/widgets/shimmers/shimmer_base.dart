// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBase extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final double radius;

  const ShimmerBase({
    super.key,
    this.width,
    this.height,
    required this.color,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          type: MaterialType.transparency,
          child: Shimmer.fromColors(
            baseColor: color.withOpacity(0.08),
            highlightColor: color.withOpacity(0.16),
            child: Container(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
