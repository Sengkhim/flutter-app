import 'package:cool_app/pages/discover_product_detail.dart';
import 'package:cool_app/theme/configs/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/base_controller.dart';
import '../controller/product_controller.dart';
import '../custom/widget/categories_builder.dart';
import '../custom/widget/loading/loading_builder.dart';
import '../custom/widget/search_bar.dart';
import 'utils/appBar_builder.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    var controller = Provider.of<ProductController>(context, listen: false);
    controller.loadOrderByCategorie(controller.currentCategory);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    var length = Provider.of<ProductController>(context, listen: false)
        .catogories
        .length;
    tabController = TabController(vsync: this, length: length);
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
      appBar: AppBarBuilder.appbarBuilder(),
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
                      ? _itemLoadingBuilder(controller)
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        floating: true,
        pinned: true,
        bottom: tabBarBuilder(value),
        expandedHeight: 160,
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
      children: const [
        //builder header
        // headerBuilder(context),
        SizedBox(height: 8),
        // //search builder
        SearchBuilder(),

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
        if (controller.catogories[value] != controller.currentCategory) {
          controller.onChange(controller.catogories[value]);
          controller.loadOrderByCategorie(controller.catogories[value]);
        }
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

  Widget _viewItemBuilder(ProductController controller) {
    return ListView.builder(
      primary: true,
      itemCount: controller.product.length,
      itemBuilder: (context, index) {
        var product = controller.product[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        DiscoverDetailPage(product: product))));
            debugPrint(product.title);
          },
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(product.thumbnail.toString())))),
              title: Text(
                product.title.toString(),
                style: const TextStyle(
                    fontSize: titleSize, fontWeight: FontWeight.w600),
              ),
              subtitle: SizedBox(
                // width: 100,
                child: Text(
                  product.description.toString(),
                  softWrap: false,
                  style: const TextStyle(
                      fontSize: subtitleSize, fontWeight: FontWeight.w500),
                ),
              ),
              trailing: Text(
                "\$${product.price}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
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
          height: 70,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: const ListTile(
            leading: SizedBox(
                height: 100,
                width: 80,
                child: ShimmerLoadingBuilder.rectangular(height: 64, width: 5)),
            title: ShimmerLoadingBuilder.rectangular(height: 16, width: 5),
            subtitle: SizedBox(
              width: 100,
              child: ShimmerLoadingBuilder.rectangular(height: 14, width: 2),
            ),
          ),
        );
      },
    );
  }
}
