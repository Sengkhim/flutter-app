import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/base_controller.dart';

class PageHandler<T extends BaseController> extends StatelessWidget {
  const PageHandler({super.key, required this.builder, required this.create});
  final Widget Function(BuildContext context, T controller, Widget? child)
      builder;
  final T Function(BuildContext context) create;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: create.call,
      child: Consumer<T>(builder: builder.call),
    );
  }
}
