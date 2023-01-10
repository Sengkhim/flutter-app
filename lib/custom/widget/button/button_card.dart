import 'package:cool_app/domain/item_model.dart';
import 'package:flutter/material.dart';
import '../../../enum/notification_type.dart';

class ButtonCartBuilder extends StatelessWidget {
  const ButtonCartBuilder(
      {super.key,
      this.item,
      required this.value,
      required this.notificationType,
      this.onPressed,
      required this.icon});
  final ItemModel? item;
  final String value;
  final NotificationType notificationType;
  final VoidCallback? onPressed;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return notificationHandler();
  }

  Widget notificationHandler() {
    switch (notificationType) {
      case NotificationType.none:
        return badgeItemCart();
      case NotificationType.appBar:
        return badgeBarCart();
      default:
        return const SizedBox();
    }
  }

  Widget badgeItemCart() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        value == "1"
            ? const SizedBox()
            : CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Text(
                  num.parse(value) >= 10 ? "9+" : value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
        IconButton(
          icon: icon,
          onPressed: onPressed,
        )
      ],
    );
  }

  Widget badgeBarCart() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        value == "1"
            ? const SizedBox()
            : CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Text(
                  num.parse(value) >= 10 ? "9+" : value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
        icon
        // IconButton(
        //   icon: icon,
        //   onPressed: onPressed,
        // )
      ],
    );
  }
}
