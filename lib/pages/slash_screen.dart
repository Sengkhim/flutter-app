import 'package:cool_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/product_controller.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  void initState() {
    Provider.of<ProductController>(context, listen: false).loadCatogories();
    // Provider.of<ProductController>(context, listen: false).loadProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
          child: IconButton(
              icon: const Icon(Icons.arrow_circle_right_sharp),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const MainPage())));
              }),
        ),
      ),
    );
  }
}
