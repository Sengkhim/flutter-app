import 'package:cool_app/pages/main_page.dart';
import 'package:cool_app/theme/configs/font_size.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import '../custom/dialogs/dialogs_card.dart';
import '../theme/colors.dart';
import 'discover_product_detail.dart';
import 'home_page.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});
  static final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    var cards = [
      "https://www.acledabank.com.kh/kh/assets/image/card-visa-debit.jpg",
      "https://i.ytimg.com/vi/HT-HgZ3flIQ/maxresdefault.jpg",
    ];
    PageIndicatorContainer container = PageIndicatorContainer(
      length: cards.length,
      // shape: IndicatorShape.roundRectangleShape(),
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
      indicatorSpace: 8,
      indicatorColor: Colors.grey[350]!,
      indicatorSelectorColor: Colors.orangeAccent,
      child: PageView(
        controller: _controller,
        children: List.generate(
            cards.length,
            (index) => SliderBox(
                    child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(cards[index]))),
                ))),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   Align(
        //     alignment: Alignment.center,
        //     child: Consumer2<AddToCardBuilder, ItemController>(
        //       builder: (context, cartController, itemController, child) {
        //         return ButtonCartBuilder(
        //           padding: const EdgeInsets.only(right: 25, top: 5),
        //           value: "5",
        //           notificationType: NotificationType.appBar,
        //           icon: Icons.shopping_bag_rounded,
        //           onPressed: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => const CartPage()));
        //           },
        //         );
        //       },
        //     ),
        //   )
        // ],
        backgroundColor: appBarColor,
        title: const Text(
          "Check Out",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          //location
          ListTile(
              leading: Icon(
                Icons.gps_fixed,
                color: appBarColor,
              ),
              title: const Text(
                "Delivery Address*",
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: titleSize),
              )),
          locationBuilder(),
          const SizedBox(height: 8),
          locationBuilder(),

          //payment methods
          ListTile(
              leading: Icon(
                Icons.payment,
                color: appBarColor,
              ),
              title: const Text(
                "Payment Method*",
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: titleSize),
              )),
          bodyBuilder(context, container),

          //deliveryDate
          Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Column(
              children: [
                const SizedBox(height: 8),
                transaction(
                    title: "Delivery Date :", trailing: "January, 13, 2023"),
                transaction(title: "Delivery :", trailing: "\$0.00"),
                const SizedBox(height: 4),
                transaction(title: "Total Price :", trailing: "\$23.40"),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 25),
          //payment
          SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width * .94,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "Your order has been sucessfully paid. It can be tracked in 'Order' section.",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: const Text(
                            "Continue shopping",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        focusColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => const MainPage()));
                        },
                        child: const Text(
                          "Go to Orders",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
              child: const Text(
                "Pay",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container locationBuilder() {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Phnom Penh, st. 410",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey),
          ),
          Checkbox(
            activeColor: Colors.orangeAccent,
            checkColor: Colors.white,
            value: true,
            onChanged: (bool? value) {
              //Password@168
              // setState(() {
              //   isChecked = value!;
              // });
            },
          )
        ],
      ),
    );
  }

  Widget transaction({String? title, String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(title!,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(trailing!,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.black45)),
        ),
      ],
    );
  }
}

Widget bodyBuilder(BuildContext context, PageIndicatorContainer container) {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white10,
    ),
    height: MediaQuery.of(context).size.height * .30,
    width: MediaQuery.of(context).size.width,
    child: container,
  );
}

// Widget paymentMethodBuilder() {}

