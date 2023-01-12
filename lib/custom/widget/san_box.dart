import 'dart:async';
import 'package:flutter/material.dart';

var image = [
  "https://i.dummyjson.com/data/products/16/1.png",
  // "https://i.dummyjson.com/data/products/16/3.jpg",
  // "https://i.dummyjson.com/data/products/16/4.jpg",
  // "https://i.dummyjson.com/data/products/16/thumbnail.jpg"
];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  SandboxState createState() => SandboxState();
}

class SandboxState extends State<Sandbox> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        // Here you can write your code
        setState(() {
          // Here you can write your code for open new view
          if (_currentPage < 2) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      });
      Future.delayed(const Duration(seconds: 15), () {
        // Here you can write your code
        setState(() {
          // Here you can write your code for open new view
          if (_currentPage < 2) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      });
      Future.delayed(const Duration(seconds: 30), () {
        // Here you can write your code
        setState(() {
          // Here you can write your code for open new view
          if (_currentPage < 2) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
            controller: _pageController,
            children: List.generate(image.length, (index) {
              return Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: 220,
                width: MediaQuery.of(context).size.width - 20,
                margin: const EdgeInsets.only(right: 5, left: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF9294cc),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image[index]))),
              );
            })
            // [
            // Container(
            //   padding: const EdgeInsets.only(left: 20, top: 20),
            //   height: 220,
            //   width: MediaQuery.of(context).size.width - 20,
            //   margin: const EdgeInsets.only(right: 5, left: 5),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30),
            //       color: const Color(0xFF9294cc),
            //       image: DecorationImage(
            //           fit: BoxFit.cover, image: NetworkImage(image[0]))),
            // ),
            //   Container(
            //     padding: const EdgeInsets.only(left: 20, top: 20),
            //     height: 220,
            //     width: MediaQuery.of(context).size.width - 20,
            //     margin: const EdgeInsets.only(right: 5, left: 5),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         color: const Color(0xFF9294cc),
            //         image: DecorationImage(
            //             fit: BoxFit.cover, image: NetworkImage(image[1]))),
            //   ),
            //   Container(
            //     padding: const EdgeInsets.only(left: 20, top: 20),
            //     height: 220,
            //     width: MediaQuery.of(context).size.width - 20,
            //     margin: const EdgeInsets.only(right: 5, left: 5),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         color: const Color(0xFF9294cc),
            //         image: DecorationImage(
            //             fit: BoxFit.cover, image: NetworkImage(image[2]))),
            //   ),
            //   Container(
            //     padding: const EdgeInsets.only(left: 20, top: 20),
            //     height: 220,
            //     width: MediaQuery.of(context).size.width - 20,
            //     margin: const EdgeInsets.only(right: 5, left: 5),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         color: const Color(0xFF9294cc),
            //         image: DecorationImage(
            //             fit: BoxFit.cover, image: NetworkImage(image[3]))),
            //   )
            // ],
            ),
      ),
    );
  }
}
