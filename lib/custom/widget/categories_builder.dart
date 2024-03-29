import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
var categories = ["Hot", "Iced", "Food", "Beer", "Set food"];

class CategoriesBuilder extends StatelessWidget {
  const CategoriesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
          direction: Axis.horizontal,
          children: categories.map(
            (e) {
              return categoriesBuilder(e);
            },
          ).toList()),
    );
  }

  Widget categoriesBuilder(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10),
      height: 35,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      )),
    );
  }
}

Widget categoriesBuilder(String title) {
  return Container(
    // margin: const EdgeInsets.only(left: 20, top: 10),
    alignment: Alignment.center,
    height: 35,
    width: 80,
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15)),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
    ),
  );
}
