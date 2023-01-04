import 'package:cool_app/controller/base_controller.dart';
import 'package:flutter/material.dart';
import '../../custom/widget/add_to_cart_flying.dart';

class AddToCardBuilderController extends BaseController {
  Widget flyingcart = const SizedBox();

  void animateBuilder() {
    flyingcart = const AddToCartAnimation();
    updateChange();
  }

  Future<void> disposeAnimateBuilder() async {
    Future.delayed(const Duration(seconds: 2), () {
      flyingcart = const SizedBox();
      updateChange();
    });
  }
}
