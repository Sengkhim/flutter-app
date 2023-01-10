import 'package:cool_app/controller/base_controller.dart';
import 'package:cool_app/enum/add_to_card_action.dart';
import 'package:flutter/material.dart';
import '../../custom/widget/add_to_cart_flying.dart';

class AddToCardBuilder extends BaseController {
  Widget flyingcart = const SizedBox();
  AddToCartAction currentCardAction = AddToCartAction.none;

  void modifieAction(AddToCartAction currentCardAction) {
    currentCardAction = this.currentCardAction;
    updateChange();
  }

  void animateBuilder() {
    flyingcart = const AddToCartAnimationBuilder();
    updateChange();
  }

  Future<void> disposeAnimateBuilder() async {
    Future.delayed(const Duration(seconds: 3), () {
      flyingcart = const SizedBox();
      updateChange();
    });
  }
}
