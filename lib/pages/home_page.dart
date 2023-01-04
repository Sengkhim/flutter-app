import 'package:cool_app/controller/animation/add_to_card_controller.dart';
import 'package:cool_app/controller/widget_builder_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/item_controller.dart';
import '../custom/widget/categories_builder.dart';
import '../custom/widget/list_view_item_builder.dart';
import '../custom/widget/san_box.dart';
import '../custom/widget/search_bar.dart';
import '../custom/widget/sliver_appbar_delegate.dart';

var image = [
  'https://restaurantclicks.com/wp-content/uploads/2022/09/Starbucks-Decaf-Coffee-Drinks.jpg',
  'https://www.tastingtable.com/img/gallery/consider-this-before-adding-syrup-and-sweetener-to-your-starbucks-drink/intro-1663619146.jpg',
  'https://hips.hearstapps.com/hmg-prod/images/the-new-chilled-cup-series-instant-drinks-will-be-news-photo-992237242-1531155941.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbbs8FNEBrg9jFGy2-GVu5rYvSl11317Sl0kI2v29G48XnuaTjpDpY9dDHLBr1su5gPEw&usqp=CAU'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          // seconaryBodyBuilder(),
          firstBodyBuilder(),

          //animation add item to cart
          Consumer<AddToCardBuilder>(
            builder: (context, value, child) => Container(
              child: value.flyingcart,
            ),
          )
        ],
      )),
      // floatingActionButton: floatingActionButtonBuilder()
    );
  }

  floatingActionButtonBuilder() {
    return Consumer<WidgetBuilderController>(
      builder: (context, value, child) => Visibility(
          visible: value.visible,
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

  Widget firstBodyBuilder() {
    return NestedScrollView(
        // floatHeaderSlivers: true,
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [sliverAppBarBuilder(context)];
        }),
        body: tabBarViewBuilder());
  }

  Widget seconaryBodyBuilder() {
    return CustomScrollView(
      slivers: [
        sliverAppBarBuilder(context),
        SliverPersistentHeader(delegate: SliverAppBarDelegate(tabBarBuilder()))
      ],
    );
  }

  Widget sliverAppBarBuilder(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: true,
      pinned: true,
      bottom: tabBarBuilder(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 8),
          child: notificationCardBuilder(
              icon: const Icon(
            Icons.shopping_bag,
            size: 30,
            color: Colors.grey,
          )),
        )
      ],
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: bodyElement(context),
      ),
    );
  }

  Widget bodyBuilder() {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: bodyElement(context),
          )
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: tabBarViewBuilder(),
      ),
    );
  }

  Widget bodyElement(BuildContext context) {
    return Column(
      children: [
        //builder header
        headerBuilder(context),

        // //search builder
        const SearchBuilder(),

        //Recommanded
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text("Recommanded",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5))),
        ),

        //page view builder
        SizedBox(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: const Sandbox()),

        // categoies_builder
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("Categories",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5))),
        ),

        //tabBarBuilder
        // tabBarBuilder(),
      ],
    );
  }

  Widget tabBarViewBuilder() {
    return TabBarView(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: const [
        ViewItemBuilder(),
        ViewItemBuilder(),
        ViewItemBuilder(),
        ViewItemBuilder(),
        ViewItemBuilder(),
      ],
    );
  }

  TabBar tabBarBuilder() {
    return TabBar(
      controller: _tabController,
      // physics: const NeverScrollableScrollPhysics(),
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black.withOpacity(0.3),
      isScrollable: true,
      indicatorWeight: 8,
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.3), width: 2)),
      ),
      tabs: [
        ...categories.map(
          (item) => Tab(
            child: Column(
              children: [
                // notificationCardBuilder(
                //     icon: const Icon(
                //   Icons.shopping_bag,
                //   size: 30,
                //   color: Colors.grey,
                // )),
                categoriesBuilder(item),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget headerBuilder(BuildContext context) {
    return const ListTile(
      title: Text("Hello Bro & Sis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text("Discount 20 percent for ordering now"),
      // trailing: notificationCardBuilder(
      //     icon: const Icon(
      //   Icons.shopping_bag,
      //   size: 32,
      // ))
    );
  }

  Widget notificationCardBuilder({required Widget icon}) {
    return Consumer<ItemController>(
      builder: (context, item, child) {
        return Stack(alignment: Alignment.topRight, children: [
          item.counter == 1
              ? const SizedBox()
              : CircleAvatar(
                  backgroundColor: Colors.red[600],
                  radius: 10,
                  child: Text(
                    item.counter >= 10 ? "9+" : item.counter.toString(),
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
              onPressed: () {},
              icon: icon,
            ),
          ),
        ]);
      },
    );
  }
}
