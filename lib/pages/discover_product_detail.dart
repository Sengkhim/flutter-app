import 'package:cool_app/domain/product_model.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import '../controller/animation/add_to_card_controller.dart';
import '../controller/item_controller.dart';
import '../custom/dialogs/dialogs_card.dart';
import '../custom/widget/button/button_card.dart';
import '../enum/notification_type.dart';

class DiscoverDetailPage extends StatefulWidget {
  const DiscoverDetailPage({super.key, required this.product});
  final ProductModel product;
  @override
  State<DiscoverDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverDetailPage> {
  ProductModel get product => widget.product;
  static final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    PageIndicatorContainer container = PageIndicatorContainer(
      length: product.images!.length,
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
      indicatorSpace: 10,
      indicatorColor: Colors.grey[350]!,
      indicatorSelectorColor: Colors.grey,
      child: PageView(
        controller: _controller,
        children: List.generate(
            product.images!.length,
            (index) => SliderBox(
                    child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(product.images![index].toString()))),
                ))),
      ),
    );
    return Scaffold(
      // appBar: appBarBuilder(context),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: bodyBuilder(context, container),
        ),
      ),
    );
  }

  Widget bodyBuilder(BuildContext context, PageIndicatorContainer container) {
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * .38,
            width: MediaQuery.of(context).size.width,
            child: container,
          ),
        ),
        detailContainer(context)
      ],
    );
  }

  Widget detailContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        productDescripiton(),
        const SizedBox(height: 4),

        //brand
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 6, bottom: 6),
          child: Text("Brand",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 6),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Align(
              alignment: Alignment.center,
              child: ListTile(
                title: Text(product.brand.toString()),
                trailing: const Icon(Icons.check),
              )),
        ),

        //colors
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 12),
          child: Text("Colors",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        colorSelector(),

        //quanitity
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 12),
          child: Text("Quantity",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        quanitityBuilder(),

        const SizedBox(height: 4),
        //add to cart
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          title: InkWell(
            onTap: () {
              CustomDialog.showDialogs<String>(
                context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                actions: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/addtocart.jpeg"))),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Success!",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Item was successfully added to cart",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Continue shopping",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Check Out",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(6)),
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          trailing: const SizedBox(
            width: 50,
            child: Icon(
              Icons.menu_open_sharp,
              color: Colors.grey,
              size: 32,
            ),
          ),
        )
      ]),
    );
  }

  Widget quanitityBuilder() {
    return ListTile(
      title: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.add),
              )),
          const SizedBox(width: 10),
          const Text(
            "1",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {},
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.remove),
              ))
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Sub total", style: TextStyle(fontWeight: FontWeight.w500)),
          Text("\$45", style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  ListTile productDescripiton() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              product.title.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text("Available ${product.stock}",
                  style: const TextStyle(fontWeight: FontWeight.w500))),
          const SizedBox(height: 4),
          Expanded(
              child: Text("Rate ${product.rating}",
                  style: const TextStyle(fontWeight: FontWeight.w500))),
          const SizedBox(height: 4),
          Expanded(
              child: Text("Off ${product.discountPercentage}%",
                  style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          product.description.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  SizedBox viewProuductBuilder() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: product.images!.length,
          itemBuilder: ((context, index) {
            return Card(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(product.images![index].toString()))),
                ),
              ),
            );
          })),
    );
  }

  Widget colorSelector() {
    var colors = [
      Colors.red,
      Colors.orange,
      Colors.blue,
      Colors.tealAccent,
      Colors.greenAccent,
    ];
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 4),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(6)),
              ),
            );
          })),
    );
  }

  AppBar appBarBuilder(BuildContext context) {
    return AppBar(
      elevation: 0.0,
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
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(Icons.shopping_bag_rounded,
                      size: 25, color: Colors.grey)),
              onPressed: () async {
                // cartController.animateBuilder();
                // await cartController.disposeAnimateBuilder();
                // itemController.addItemToCard(item.id, item);
                // itemController.submitedCart(itemController.itemListCard);
              },
            );
          },
        )
      ],
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)),
    );
  }
}

class SliderBox extends StatelessWidget {
  final Widget? child;
  const SliderBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(bottom: 35), child: child);
  }
}
