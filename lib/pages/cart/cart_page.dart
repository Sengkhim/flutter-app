import 'package:cool_app/custom/dialogs/dialogs_card.dart';
import 'package:cool_app/pages/check_out_page.dart';
import 'package:flutter/material.dart';
import '../../custom/button/adjustment_builder.dart';
import '../../theme/colors.dart';

String img = 'https://i.dummyjson.com/data/products/16/1.png';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your cart",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline_rounded,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //list item add in cart
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              width: double.infinity,
              child: cartListBuilder(),
            ),

            //transaction
            transactionBuilder(),

            //check out
            SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width * .94,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const CheckOutPage()));
                },
                child: const Text(
                  "Check Out",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget transactionBuilder() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "Goods:",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Delivery:",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
              ),
            ),
            trailing: Column(
              children: const [
                Text(
                  "\$22,34",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "\$0.00",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ],
            ),
          ),

          //total
          const ListTile(
            title: Text(
              "Total Price:",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            ),
            trailing: Text(
              "\$22,34",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget cartListBuilder() {
    return ListView.builder(
        // controller: ScrollController(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: ((context, index) {
          return InkWell(
            focusColor: Colors.white10,
            splashColor: Colors.white10,
            highlightColor: Colors.white10,
            onTap: () {
              CustomDialog.showDialogs<String>(
                context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                actions: [
                  Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(right: 4, left: 4),
                      title: const Text(
                        "Do you want to remove this item?",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                            fontSize: 14),
                      ),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Okay")),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 80,
                              width: 100,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(img))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration:
                                  const BoxDecoration(color: Colors.white10),
                              child: const ListTile(
                                contentPadding: EdgeInsets.only(left: 15),
                                title: Text("Apple",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14)),
                                subtitle: Text("\$45,90",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    )),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                  focusColor: Colors.white,
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_circle,
                                      color: Colors.orangeAccent),
                                  padding: const EdgeInsets.only(top: 10)),
                              const Text(
                                "1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.orangeAccent),
                              ),
                              IconButton(
                                  focusColor: Colors.white,
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.orangeAccent),
                                  padding: const EdgeInsets.only(bottom: 10)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),
                  //check out
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => const CheckOutPage()));
                      },
                      child: const Text(
                        "Check Out",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
            onLongPress: () {
              // CustomDialog.showDialogs<String>(context);
            },
            onDoubleTap: () {
              // CustomDialog.showDialogs<String>(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(img))),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: const ListTile(
                        title: Text("D"),
                        subtitle: Text("dd"),
                      ),
                    ),
                  ),
                  adjustmentButton(),
                ],
              ),
            ),
          );
        }));
  }

  Widget adjustmentButton() {
    return Expanded(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            AdjustMentBuilder(
              onPressed: () {},
              icon: Icons.add,
            ),
            const Text(
              "1",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            AdjustMentBuilder(
              onPressed: () {},
              icon: Icons.remove,
            )
          ],
        ),
      ),
    );
  }
}
