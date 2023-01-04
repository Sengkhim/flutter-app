import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/animation/add_to_card_controller.dart';
import 'controller/item_controller.dart';
import 'controller/widget_builder_controller.dart';
import 'pages/my_application.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ItemController()),

      //animationController
      ChangeNotifierProvider(create: (context) => AddToCardBuilder()),
      Provider(create: ((context) => WidgetBuilderController())),
    ],
    child: const MainApplication(),
  ));
}
