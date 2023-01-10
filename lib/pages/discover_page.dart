// import 'package:cool_app/pages/discover_product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/base_controller.dart';
import '../controller/product_controller.dart';
import '../custom/widget/categories_builder.dart';
import '../custom/widget/loading/loading_builder.dart';
import '../custom/widget/search_bar.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController _scrollViewController;
  late List<dynamic> tempCategorie;

  @override
  void initState() {
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    // var controller = Provider.of<ProductController>(context, listen: false);
    Provider.of<ProductController>(context, listen: false).loadCatogories();
    Provider.of<ProductController>(context, listen: false).loadProduct();
    var length = Provider.of<ProductController>(context, listen: false)
        .catogories
        .length;
    tabController =
        TabController(vsync: this, length: length == 0 ? 20 : length);
    // controller.currentCategory = controller.catogories.first;
    // debugPrint(controller.currentCategory);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductController>(
          builder: (context, value, child) =>
              value.loadingState == LoadingState.onProcessing
                  ? Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CupertinoActivityIndicator(),
                          Text("Loading....."),
                        ],
                      ))
                  : customBodyBuilder(),
        ),
      ),
    );
  }

  Widget customBodyBuilder() {
    var controller = context.watch<ProductController>();
    return CustomScrollView(slivers: [
      sliverAppBarBuilder(context),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: DefaultTabController(
              length: controller.catogories.length,
              child: Container(
                  alignment: Alignment.center,
                  child: controller.loadingStateView ==
                          LoadingStateView.onProcessing
                      // ? const CupertinoActivityIndicator()
                      ? LoadingBuilder(
                          enabled: true,
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.withOpacity(0.2),
                          child: _itemLoadingBuilder(controller),
                        )
                      : tabBarViewBuilder(controller)),
            ),
          ),
        ]),
      ),
    ]);
  }

  Widget sliverAppBarBuilder(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, value, child) => SliverAppBar(
        backgroundColor: Colors.white,
        floating: true,
        pinned: true,
        bottom: tabBarBuilder(value),
        expandedHeight: 230,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: bodyElement(context),
        ),
      ),
    );
  }

  Widget headerBuilder(BuildContext context) {
    return const ListTile(
      title: Text("Hello Bro & Sis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text("Discount 20 percent for ordering now"),
    );
  }

  Widget bodyElement(BuildContext context) {
    return Column(
      children: [
        //builder header
        headerBuilder(context),

        // //search builder
        const SearchBuilder(),

        // categoies_builder
        const Align(
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
              child: Column(
                children: [
                  categoriesBuilder(item.toString()),
                ],
              ),
            ),
          )
          .toList(),
      onTap: (value) {
        controller.onChange(controller.catogories[value]);
        controller.loadOrderByCategorie(controller.catogories[value]);
      },
    );
  }

  Widget tabBarViewBuilder(ProductController c) {
    return Consumer<ProductController>(
      builder: (context, controller, child) => TabBarView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: List.generate(controller.catogories.length, (index) {
            return _viewItemBuilder(controller);
          })),
    );
  }

  ListView _viewItemBuilder(ProductController controller) {
    return ListView.builder(
      primary: true,
      itemCount: controller.product.length,
      itemBuilder: (context, index) {
        var product = controller.product[index];
        return Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(product.images!.first.toString())))),
            title: Text(product.brand.toString()),
            subtitle: Text(product.description.toString()),
          ),
        );
      },
    );
  }

  ListView _itemLoadingBuilder(ProductController controller) {
    return ListView.builder(
      primary: true,
      itemCount: controller.product.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(5)),
        );
      },
    );
  }

  // Widget objectBuilder(ProductController controller) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => const DiscoverDetailPage()));
  //     },
  //     child: ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: controller.catogories.length,
  //         itemBuilder: ((context, index) {
  //           var product = controller.catogories[index];
  //           return Container(
  //             margin: const EdgeInsets.all(4),
  //             decoration: const BoxDecoration(color: Colors.white),
  //             child: ListTile(
  //               // leading: Container(
  //               //     height: 100,
  //               //     width: 80,
  //               //     decoration: BoxDecoration(
  //               //         image: DecorationImage(
  //               //             image: NetworkImage(
  //               //                 product.images!.first.toString())))),
  //               title: Text(product.toString()),
  //               subtitle: Text(product.toString()),
  //             ),
  //           );
  //         })),
  //   );
  // }
}
