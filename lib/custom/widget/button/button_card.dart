import 'package:cool_app/domain/item_model.dart';
import 'package:cool_app/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../../enum/notification_type.dart';

class ButtonCartBuilder extends StatelessWidget {
  const ButtonCartBuilder(
      {super.key,
      this.item,
      required this.value,
      required this.notificationType,
      this.onPressed,
      required this.icon,
      required this.padding});
  final ItemModel? item;
  final String value;
  final NotificationType notificationType;
  final VoidCallback? onPressed;
  final IconData icon;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return badgeBarCart();
  }

  // Widget notificationHandler() {
  //   switch (notificationType) {
  //     case NotificationType.none:
  //       return badgeItemCart();
  //     case NotificationType.appBar:
  //       return badgeBarCart();
  //     default:
  //       return const SizedBox();
  //   }
  // }

  // Widget badgeItemCart() {
  //   return Stack(
  //     alignment: Alignment.topRight,
  //     children: [
  //       value == "1"
  //           ? const SizedBox()
  //           : CircleAvatar(
  //               backgroundColor: Colors.red,
  //               radius: 10,
  //               child: Text(
  //                 num.parse(value) >= 10 ? "9+" : value,
  //                 style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 12.5,
  //                     fontWeight: FontWeight.bold),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //       IconButton(
  //         icon: icon,
  //         onPressed: onPressed,
  //       )
  //     ],
  //   );
  // }

  Widget badgeBarCart() {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      focusColor: appBarColor,
      splashColor: appBarColor,
      highlightColor: appBarColor,
      onTap: onPressed,
      child: Stack(
        children: [
          Icon(icon, size: 30),
          // icon,
          Visibility(
            visible: true,
            child: Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
