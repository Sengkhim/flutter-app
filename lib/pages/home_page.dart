import 'dart:core';
import 'package:cool_app/controller/animation/add_to_card_controller.dart';
import 'package:cool_app/controller/base_controller.dart';
import 'package:cool_app/controller/product_controller.dart';
import 'package:cool_app/controller/widget/widget_builder_controller.dart';
import 'package:cool_app/custom/widget/loading/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/item_controller.dart';
import '../custom/widget/button/button_card.dart';
import '../custom/widget/categories_builder.dart';
import '../custom/widget/search_bar.dart';
import '../domain/product_model.dart';
import '../enum/notification_type.dart';
import '../theme/colors.dart';
import '../theme/configs/font_size.dart';
import 'cart/flying_card_animation.dart';
import 'discover_product_detail.dart';
import 'helpers/animation.dart';
import 'utils/appBar_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  late ScrollController _scrollViewController;
  late AnimationController moveController;
  late Animation moveAnimation;
  Position? fromPosition;
  GlobalKey starKey = GlobalKey();
  List<GlobalKey> keyCap = [];

  @override
  void initState() {
    final controller = Provider.of<ProductController>(context, listen: false);
    controller.loadOrderByCategorie(controller.currentCategory);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    var length = Provider.of<ProductController>(context, listen: false)
        .catogories
        .length;
    tabController = TabController(vsync: this, length: length);
    keyCap = List<GlobalKey>.generate(
        length, (index) => GlobalKey(debugLabel: 'key_$index'),
        growable: false);
    //ANIMATION
    moveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
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
    tabController.dispose();
    _scrollViewController.dispose();
    moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.appbarBuilder(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const CartPage()));
        },
      ),
      body: SafeArea(child: bodyBuilder()),
      // floatingActionButton: floatingActionButtonBuilder()
    );
  }

  Widget cartFlyingBuilder() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CartFlyingBuilder(
            moveAnimation: moveAnimation,
            fromPosition: fromPosition,
            starKey: starKey,
            moveController: moveController,
          ),
          ButtonCartBuilder(
            padding: const EdgeInsets.only(right: 0, top: 0),
            value: "9",
            notificationType: NotificationType.appBar,
            icon: Icons.shopping_bag_outlined,
            onPressed: (() {}),
          ),
        ],
      ),
    );
  }

  Widget bodyBuilder() {
    var controller = context.watch<ProductController>();
    return RefreshIndicator(
      onRefresh: () async {
        debugPrint("object");
      },
      child: Container(
          color: Colors.grey[200],
          child: CustomScrollView(
            slivers: [
              //search and cart
              SliverToBoxAdapter(
                child: Container(
                  // margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  color: Colors.white,
                  child: Row(
                    // alignment: Alignment.bottomLeft,
                    children: [
                      const Expanded(flex: 8, child: SearchBuilder()),
                      // const SizedBox(width: 15),
                      Expanded(child: cartFlyingBuilder()),
                    ],
                  ),
                ),
              ),
              sliverAppBarBuilder(context),
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 245,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return controller.loadingStateView ==
                              LoadingStateView.onProcessing
                          ? gridShimmerLoading()
                          : gridItemBuilder(
                              controller.product[index], keyCap[index]);
                    },
                    childCount: controller.product.length,
                  ),
                ),
              ),
            ],
          )),
    );
    // });
  }

  Widget gridShimmerLoading() {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 130,
            width: 180,
            margin: const EdgeInsets.all(10),
            child:
                const ShimmerLoadingBuilder.rectangular(width: 50, height: 50),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 15, right: 10),
            title:
                const ShimmerLoadingBuilder.rectangular(width: 50, height: 20),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child:
                      ShimmerLoadingBuilder.rectangular(width: 60, height: 15),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child:
                      ShimmerLoadingBuilder.rectangular(width: 50, height: 10),
                ),
              ],
            ),
            trailing:
                const ShimmerLoadingBuilder.rectangular(width: 40, height: 35),
          ),
        ],
      ),
    );
  }

  Widget gridItemBuilder(ProductModel product, GlobalKey key) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => DiscoverDetailPage(product: product)));
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            //image
            Container(
              height: 130,
              width: 180,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(product.thumbnail.toString()))),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                // color: Colors.red,
                margin: const EdgeInsets.only(left: 12),
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Text(
                      product.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: titleSize,
                          color: titleColor),
                    ),
                    const SizedBox(height: 4),
                    //price
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text("\$${product.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: subtitleSize,
                              color: subtitleColor)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 20,
                            width: 80,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: ((context, index) {
                                  return const Icon(Icons.star,
                                      color: Colors.orangeAccent, size: 16);
                                })),
                          ),
                        ),
                        //ADD TO CARD ANIMATION FLYING
                        Consumer<CartAnimationControlller>(
                          builder: (context, value, child) => InkWell(
                              onTap: () {
                                setState(() {
                                  fromPosition = getPositionByKey(key);
                                });
                                moveController.reset();
                                moveController.forward();
                                // value.animateBuilder();
                                // debugPrint("Added");
                              },
                              splashColor: Colors.white,
                              focusColor: Colors.white,
                              highlightColor: Colors.white,
                              child: Container(
                                alignment: Alignment.center,
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(50)),
                                child:
                                    Icon(Icons.shopping_bag_outlined, key: key),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  floatingActionButtonBuilder() {
    return Consumer<WidgetBuilderController>(
      builder: (context, value, child) => Visibility(
          // visible: value.visible,
          visible: true,
          child: FloatingActionButton(
            isExtended: true,
            backgroundColor: Colors.grey.withOpacity(0.4),
            onPressed: () {},
            child: notificationCardBuilder(
                icon: const Icon(
              Icons.shopping_bag,
              size: 30,
              color: Colors.grey,
            )),
          )),
    );
  }

  Widget sliverAppBarBuilder(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, value, child) => SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        floating: true,
        pinned: true,
        bottom: tabBarBuilder(value),
        // expandedHeight: 415,
        expandedHeight: 90,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: bodyElement(context),
        ),
      ),
    );
  }

  Widget bodyElement(BuildContext context) {
    return Column(
      children: const [
        // SizedBox(height: 8),
        //search builder
        // SearchBuilder(),

        //Recommanded
        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //       child: Text("Recommanded",
        //           style:
        //               TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5))),
        // ),

        //page view builder
        // SizedBox(
        //     height: 220,
        //     width: MediaQuery.of(context).size.width,
        //     child: const Sandbox()),

        // categoies_builder
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("Categories",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5))),
        ),
      ],
    );
  }

  TabBar tabBarBuilder(ProductController controller) {
    return TabBar(
      controller: tabController,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black.withOpacity(0.3),
      isScrollable: true,
      indicatorColor: Colors.red,
      indicatorWeight: 8,
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.3), width: 2)),
      ),
      tabs: controller.catogories
          .map(
            (item) => Tab(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: controller.currentCategory != item.toString()
                        ? Colors.white
                        : Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(8)),
                child:
                    categoriesBuilder(item.toString(), controller: controller),
              ),
            ),
          )
          .toList(),
      onTap: (value) {
        // controller.tabBarAction(controller.catogories[value]);
        if (controller.catogories[value] != controller.currentCategory) {
          controller.onChange(controller.catogories[value]);
          controller.loadOrderByCategorie(controller.catogories[value]);
        }
      },
    );
  }

  Widget headerBuilder(BuildContext context) {
    return const ListTile(
      title: Text("Hello Bro & Sis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text("Discount 20 percent for ordering now"),
    );
  }

  Widget notificationCardBuilder({required Widget icon}) {
    return Consumer2<CartAnimationControlller, ItemController>(
      builder: (context, cartController, itemController, child) {
        return ButtonCartBuilder(
          padding: const EdgeInsets.all(0),
          value: "5",
          // value: itemController.currentQtyItem(item.id.toString()).toString(),
          notificationType: NotificationType.appBar,
          icon: Icons.shopping_bag_rounded,
          // icon: Container(
          //     alignment: Alignment.center,
          //     height: 50,
          //     width: 50,
          //     decoration: BoxDecoration(
          //         color: Colors.grey.withOpacity(0.2),
          //         borderRadius: BorderRadius.circular(50)),
          //     child: const Icon(Icons.shopping_bag_rounded,
          //         size: 30, color: Colors.grey)),
          onPressed: () async {
            // cartController.animateBuilder();
            // await cartController.disposeAnimateBuilder();
            // itemController.addItemToCard(item.id, item);
            // itemController.submitedCart(itemController.itemListCard);
          },
        );
      },
    );
  }
}
