import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/animation/add_to_card_controller.dart';
import 'controller/base_controller.dart';
import 'controller/item_controller.dart';
import 'controller/product_controller.dart';
import 'controller/widget/widget_builder_controller.dart';
import 'pages/my_application.dart';
import 'service/context/service_context.dart';
import 'service/product_service.dart';

void main() {
  var context = ServiceContext();
  ProductServerice service = ProductServerice(context: context);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => ProductController(service: service)),
      ChangeNotifierProvider(create: (context) => ItemController()),

      //animationController
      ChangeNotifierProvider(create: (context) => CartAnimationControlller()),
      ChangeNotifierProvider(create: (context) => BaseController()),
      ChangeNotifierProvider(create: (context) => WidgetBuilderController()),
    ],
    child: const MainApplication(),
  ));
}
