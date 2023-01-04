import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/item_controller.dart';

class NotificationBuilder extends StatelessWidget {
  const NotificationBuilder(
      {super.key,
      required this.icon,
      required this.value,
      required this.onPressed});
  final Widget icon;
  final String value;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
      builder: (context, item, child) {
        return Stack(alignment: Alignment.topRight, children: [
          value == "1"
              ? const SizedBox()
              : CircleAvatar(
                  backgroundColor: Colors.red[600],
                  radius: 10,
                  child: Text(
                    // item.counter >= 10 ? "9+" : item.counter.toString()
                    value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: onPressed,
              icon: icon,
            ),
          ),
        ]);
      },
    );
  }
}
