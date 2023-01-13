import 'package:flutter/material.dart';
import '../helpers/animation.dart';

class CartFlyingBuilder extends StatelessWidget {
  const CartFlyingBuilder(
      {super.key,
      required this.moveController,
      required this.moveAnimation,
      this.fromPosition,
      required this.starKey});
  final AnimationController moveController;
  final Animation moveAnimation;
  final Position? fromPosition;
  final GlobalKey starKey;
  @override
  Widget build(BuildContext context) {
    if (fromPosition == null) {
      return const SizedBox.shrink();
    }
    return Container(
      key: starKey,
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: Colors.orangeAccent, borderRadius: BorderRadius.circular(8)),
      child: AnimatedBuilder(
        animation: moveAnimation,
        builder: (context, child) {
          Position currentPosition;
          double x = 0, y = 0;
          if (starKey.currentContext?.findRenderObject() != null) {
            currentPosition = getPositionByKey(starKey);
            x = fromPosition!.x - currentPosition.x;
            y = fromPosition!.y - currentPosition.y;
          }
          if (x == 0) return Container();
          return Transform.translate(
            offset: Offset(
                x * (1 - moveAnimation.value), y * (1 - moveAnimation.value)),
            child: Opacity(
              opacity: fromPosition == null ? 0.0 : 1.0,
              child:
                  const Icon(Icons.shopping_bag_outlined, color: Colors.orangeAccent),
            ),
          );
        },
      ),
    );
  }
}
