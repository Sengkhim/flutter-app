import 'package:flutter/material.dart';

class AddToCartAnimation extends StatefulWidget {
  const AddToCartAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddToCartAnimationState createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size biggest = constraints.biggest;
      return Stack(
        children: [
          PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTRB(biggest.width - 90, biggest.height - 200,
                        biggest.width, biggest.height),
                    biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTRB(biggest.width - 80, -710, biggest.width,
                        biggest.height),
                    biggest),
              ).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.ease)),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.shopping_bag, color: Colors.grey, size: 32),
              ))
        ],
      );
    });
  }
}
