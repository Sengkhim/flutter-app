import 'package:flutter/material.dart';
import '../controller/widget_builder_controller.dart';
import 'base/page_handler.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'setting_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widget = <Widget>[
      const HomePage(),
      const FavoritePage(),
      const SettingPage()
    ];
    return PageHandler<WidgetBuilderController>(
        create: (context) => WidgetBuilderController(),
        builder: (context, controller, child) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: widget.elementAt(controller.currentPage as int),
              ),
            ),
            bottomNavigationBar: bottomNavBarBuilder(controller),
          );
        });
  }

  Widget bottomNavBarBuilder(WidgetBuilderController controller) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        childBottomNavBar(label: "Home", icon: Icons.home),
        childBottomNavBar(label: "Favorite", icon: Icons.favorite),
        childBottomNavBar(label: "Setting", icon: Icons.settings),
      ],
      elevation: 5,
      currentIndex: controller.currentPage as int,
      selectedItemColor: Colors.blue[800],
      onTap: (index) {
        controller.onChangePage(index);
      },
    );
  }

  BottomNavigationBarItem childBottomNavBar({String? label, IconData? icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }
}

