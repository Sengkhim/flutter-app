import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder(
      {super.key,
      required this.child,
      required this.baseColor,
      required this.highlightColor,
      required this.enabled});
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    // return const CupertinoActivityIndicator();
    return Shimmer.fromColors(
        enabled: enabled,
        baseColor: baseColor,
        highlightColor: highlightColor,
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 2500),
        child: child);
  }
}
