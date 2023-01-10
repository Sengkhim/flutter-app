import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/widget/widget_builder_controller.dart';
import 'discover_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'setting_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widget = <Widget>[
      const HomePage(),
      const DiscoverPage(),
      const FavoritePage(),
      const SettingPage()
    ];
    // return PageHandler<WidgetBuilderController>(
    //     create: (context) => WidgetBuilderController(),
    //     builder: (context, controller, child) {
      var controller = Provider.of<WidgetBuilderController>(context);
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: widget.elementAt(controller.currentPage as int),
              ),
            ),
            bottomNavigationBar: bottomNavBarBuilder(controller),
          );
        // });
  }

  Widget bottomNavBarBuilder(WidgetBuilderController controller) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        childBottomNavBar(label: "Home", icon: Icons.home),
        childBottomNavBar(label: "Discover", icon: Icons.now_widgets_rounded),
        childBottomNavBar(label: "Favorite", icon: Icons.favorite_sharp),
        childBottomNavBar(label: "Setting", icon: Icons.settings),
      ],
      elevation: 5,
      currentIndex: controller.currentPage as int,
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
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
