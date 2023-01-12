import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/animation/add_to_card_controller.dart';
import '../../controller/item_controller.dart';
import '../../custom/widget/button/button_card.dart';
import '../../enum/notification_type.dart';

abstract class AppBarBuilder extends PreferredSizeWidget {
  // const AppBarBuilder({this.onTap});
//  static late final VoidCallback? onTap;
  static AppBar appbarBuilder({VoidCallback? onTap}) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0.0,
      title: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Hello, Welcome to BEN SHOP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black)),
          SizedBox(height: 5),
          Text("Today off 50%",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black))
        ],
      ),
      backgroundColor: Colors.white,
      actions: [
        Consumer2<AddToCardBuilder, ItemController>(
          builder: (context, cartController, itemController, child) {
            return ButtonCartBuilder(
              padding: const EdgeInsets.only(right: 18, top: 5),
              value: "5",
              // value: itemController.currentQtyItem(item.id.toString()).toString(),
              notificationType: NotificationType.appBar,
              icon: Container(
                  alignment: Alignment.center,
                  // height: 50,
                  // width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(Icons.shopping_bag_rounded,
                      size: 25, color: Colors.grey)),
              onPressed: onTap,
            );
          },
        )
      ],
    );
  }
}

// AppBar appBarBuilder(bool leading) {
//   return AppBar(
//     automaticallyImplyLeading: leading,
//     centerTitle: false,
//     elevation: 0.0,
//     title: Column(
//       // mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text("Hello, Welcome to BEN SHOP",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: Colors.black)),
//         SizedBox(height: 5),
//         Text("Today off 50%",
//             style: TextStyle(
//                 fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black))
//       ],
//     ),
//     backgroundColor: Colors.white,
//     actions: [
//       Consumer2<AddToCardBuilder, ItemController>(
//         builder: (context, cartController, itemController, child) {
//           return ButtonCartBuilder(
//             padding: const EdgeInsets.only(right: 18, top: 5),
//             value: "5",
//             // value: itemController.currentQtyItem(item.id.toString()).toString(),
//             notificationType: NotificationType.appBar,
//             icon: Container(
//                 alignment: Alignment.center,
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(50)),
//                 child: const Icon(Icons.shopping_bag_rounded,
//                     size: 24, color: Colors.grey)),
//             onPressed: () async {
//               // cartController.animateBuilder();
//               // await cartController.disposeAnimateBuilder();
//               // itemController.addItemToCard(item.id, item);
//               // itemController.submitedCart(itemController.itemListCard);
//             },
//           );
//         },
//       )
//     ],
//   );
// }
