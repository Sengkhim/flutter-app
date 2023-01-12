import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/base_controller.dart';
import '../controller/product_controller.dart';
import '../custom/widget/loading/loading_builder.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    // Provider.of<ProductController>(context, listen: false).loadProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // loading()
            // bodyBuilder(),
          ],
        ),
      ),
    );
  }

  // Widget loading() {
  //   return ListView.builder(
  //       itemCount: 5,
  //       itemBuilder: (context, index) {
  //         return const ListTile(
  //           leading: ShimmerLoadingBuilder.rectangular(height: 64, width: 64),
  //           title: ShimmerLoadingBuilder.rectangular(height: 16),
  //           subtitle: ShimmerLoadingBuilder.rectangular(height: 14),
  //         );
  //       });
  // }

  // Widget bodyBuilder() {
  //   return Consumer<ProductController>(builder: (context, controller, child) {
  //     return controller.loadingState == LoadingState.onProcessing
  //         ? LoadingBuilder(
  //             enabled: true,
  //             baseColor: Colors.white,
  //             highlightColor: Colors.grey.withOpacity(0.1),
  //             child: objectBuilder(controller),
  //           )
  //         : objectBuilder(controller);
  //   });
  // }

  Widget objectBuilder(ProductController controller) {
    return ListView.builder(
        itemCount: controller.product.length,
        itemBuilder: ((context, index) {
          var product = controller.product[index];
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: Container(
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage(product.images!.first.toString())))),
              // leading: CircleAvatar(
              //   radius: 32,
              //   backgroundImage: NetworkImage(product.images!.first.toString()),
              // ),
              title: Text(product.brand.toString()),
              subtitle: Text(product.description.toString()),
            ),
          );
        }));
  }
}
