import 'package:flutter/material.dart';
import 'main_page.dart';

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}
