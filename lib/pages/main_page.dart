import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/widget/widget_builder_controller.dart';
import 'discover_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// ignore: camel_case_types
typedef delegateNavigationBar = bool Function(int index);

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widget = <Widget>[
      const HomePage(),
      const DiscoverPage(),
      const FavoritePage(),
      const SettingPage()
    ];
    var controller = Provider.of<WidgetBuilderController>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: widget.elementAt(controller.currentPage as int),
        ),
      ),
      bottomNavigationBar: bottomNavBarBuilder(controller),
    );
  }

  Widget bottomNavBarBuilder(WidgetBuilderController controller) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        childBottomNavBar(
            label: "Home",
            icon: Icons.home,
            current: controller.actionNavigation(0)),
        childBottomNavBar(
            label: "Discover",
            icon: Icons.now_widgets_rounded,
            current: controller.actionNavigation(1)),
        childBottomNavBar(
            label: "Favorite",
            icon: Icons.favorite_sharp,
            current: controller.actionNavigation(2)),
        childBottomNavBar(
            label: "Setting",
            icon: Icons.settings,
            current: controller.actionNavigation(3)),
      ],
      elevation: 5,
      currentIndex: controller.currentPage as int,
      selectedItemColor: Colors.orangeAccent,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      selectedIconTheme: const IconThemeData(color: Colors.orangeAccent),
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      onTap: (index) {
        controller.onChangePage(index);
        controller.actionNavigation(index);
      },
    );
  }

  BottomNavigationBarItem childBottomNavBar(
      {String? label, IconData? icon, bool? current}) {
    return BottomNavigationBarItem(
      tooltip: label,
      label: '',
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: current == false ? Colors.white10 : Colors.orangeAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    icon,
                    color: current == false ? Colors.grey : Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Visibility(
                    visible: current!,
                    child: Expanded(
                      child: Text(
                        label!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
