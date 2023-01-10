import 'package:cool_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/categories_builder.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  // late TabController tabController;
  @override
  void initState() {
    // final controller = Provider.of<ProductController>(context, listen: false);
    // controller.loadCatogories();
    // controller.loadProduct();
    // controller.tabController =
    //     TabController(vsync: this, length: controller.catogories.length);
    super.initState();
  }

  // TabController get tabController => _tabController;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, value, child) => TabBar(
        controller: value.tabController,
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black.withOpacity(0.3),
        isScrollable: true,
        indicatorWeight: 8,
        indicator: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom:
                  BorderSide(color: Colors.black.withOpacity(0.3), width: 2)),
        ),
        tabs: [
          ...value.catogories.map(
            (item) => Tab(
              child: Column(
                children: [
                  categoriesBuilder(item.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
