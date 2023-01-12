import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingBuilder extends StatelessWidget {
  const ShimmerLoadingBuilder.rectangular({
    super.key,
    // this.width = double.infinity,
    required this.width,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerLoadingBuilder.circular(
      {super.key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        period: const Duration(milliseconds: 2500),
        child: Container(
          width: width,
          height: height,
          decoration:
              ShapeDecoration(color: Colors.grey[300], shape: shapeBorder),
        ));
  }
}
