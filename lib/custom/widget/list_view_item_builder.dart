import 'package:cool_app/controller/widget/widget_builder_controller.dart';
import 'package:cool_app/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../controller/animation/add_to_card_controller.dart';
import '../../controller/item_controller.dart';
import '../../domain/item_model.dart';
import '../../enum/add_to_card_action.dart';
import 'button/button_card.dart';

class ViewItemBuilder extends StatefulWidget {
  const ViewItemBuilder({super.key});

  @override
  State<ViewItemBuilder> createState() => _ViewItemBuilderState();
}

class _ViewItemBuilderState extends State<ViewItemBuilder> {
  @override
  void initState() {
    // ScrollController _scrollController = animateTo(_scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetBuilderController>(
      builder: (context, value, child) =>
          NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            value.visibility(false);
          } else if (notification.direction == ScrollDirection.reverse) {
            value.visibility(true);
          } else if (notification.direction == ScrollDirection.idle) {
            value.visibility(false);
          } else if (notification.direction == ScrollDirection.values.first) {
            value.visibility(false);
          }
          return false;
        },
        child: ListView.builder(
            // controller: _scrollController,
            primary: true,
            itemCount: ItemModel.itemList.length,
            itemBuilder: (context, index) {
              return itemListBuilder(context, index);
            }),
      ),
    );
  }

  Widget itemListBuilder(BuildContext context, int index) {
    var item = ItemModel.itemList[index];
    var itemController = Provider.of<ItemController>(context, listen: false);
    return Slidable(
      key: Key(UniqueKey().toString()),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 8),
                      Consumer<AddToCardBuilder>(
                        builder: (context, value, child) => adjustButtonBuilder(
                          const Icon(Icons.add),
                          onPressed: () {
                            value.modifieAction(AddToCartAction.onAdjustment);
                            itemController.addItemToCard(item.id, item);
                          },
                        ),
                      ),
                      Consumer<ItemController>(
                          builder: ((context, value, child) {
                        return Text(value.currentQtyItem(item.id.toString())!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400));
                      })),
                      Consumer<AddToCardBuilder>(
                        builder: (context, value, child) => adjustButtonBuilder(
                          const Icon(Icons.remove),
                          onPressed: () {
                            value.modifieAction(AddToCartAction.onAdjustment);
                            itemController.removeItemFormCard(item);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  )),
            ),
          ),
        ],
      ),
      child: _containerBuilder(item, context),
    );
  }

  Widget adjustButtonBuilder(Widget icon, {VoidCallback? onPressed}) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 35,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15)),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: 20,
      ),
    );
  }

  Widget _containerBuilder(ItemModel item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(item.image.toString()),
          ),
          trailing: Consumer2<AddToCardBuilder, ItemController>(
            builder: (context, cartController, itemController, child) {
              return ButtonCartBuilder(
                padding: const EdgeInsets.all(0),
                item: item,
                value: itemController
                    .currentQtyItem(item.id.toString())
                    .toString(),
                notificationType: NotificationType.none,
                icon: const Icon(Icons.shopping_cart, size: 32),
                onPressed: () async {
                  switch (cartController.currentCardAction) {
                    case AddToCartAction.onAdjustment:
                      itemController.addItemToCard(item.id, item);
                      break;
                    case AddToCartAction.onClick:
                      cartController.animateBuilder();
                      await cartController.disposeAnimateBuilder();
                      itemController.submitedCart(itemController.itemListCard);
                      break;
                    default:
                  }
                },
              );
            },
          ),
          title: Text(
            item.name.toString(),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("\$${item.price.toString()}"),
          ),
        ),
      ),
    );
  }
}
