import 'package:flutter/material.dart';

import '../helpers/animation.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  late AnimationController moveController;
  late Animation moveAnimation;

  Position? fromPosition;
  GlobalKey starKey = GlobalKey();

  @override
  void initState() {
    moveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    moveAnimation =
        CurvedAnimation(parent: moveController, curve: Curves.easeInOut);

    moveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          fromPosition = null;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey();
    final fromKey1 = GlobalKey();
    final fromKey2 = GlobalKey();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(child: SizedBox.shrink()),
                Container(child: Icon(Icons.weekend, key: fromKey2)),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fromPosition = getPositionByKey(fromKey2);
                      });
                      moveController.reset();
                      moveController.forward();
                    },
                    child: const Text('start animation')),
                const Expanded(child: SizedBox.shrink()),
                Container(child: Icon(Icons.weekend, key: fromKey)),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fromPosition = getPositionByKey(fromKey);
                      });
                      moveController.reset();
                      moveController.forward();
                    },
                    child: const Text('start animation')),
                const Expanded(child: SizedBox.shrink()),
                Container(child: Icon(Icons.weekend, key: fromKey1)),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fromPosition = getPositionByKey(fromKey1);
                      });
                      moveController.reset();
                      moveController.forward();
                    },
                    child: const Text('start animation')),
              ],
            ),
            gg(),
          ],
        ),
      ),
    );
  }

  Row gg() {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 40,
          width: 40,
          child: Stack(
            children: [
              buildFlyWidget(),
              Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(5),
                  child: const Icon(Icons.shopping_cart, color: Colors.black)),
            ],
          ),
        )
      ],
    );
  }

  Widget buildFlyWidget() {
    if (fromPosition == null) {
      return const SizedBox.shrink();
    }
    return Container(
      color: Colors.amber,
      key: starKey,
      height: 24,
      width: 24,
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
              child: const Icon(Icons.weekend_outlined, color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}

