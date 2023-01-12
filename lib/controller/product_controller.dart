import 'package:cool_app/controller/base_controller.dart';
import 'package:cool_app/domain/product_model.dart';
import 'package:flutter/material.dart';
import '../service/product_service.dart';

class ProductController extends BaseController {
  final ProductServerice service;

  ProductController({required this.service}) {
    // loadProduct();
    // loadCatogories();
  }

  late TabController tabController;
  late String currentCategory = '';
  late List<ProductModel> _pruduct = [];
  late List<dynamic> _catogories = [];

  List<ProductModel> get product => _pruduct;
  List<dynamic> get catogories => _catogories;
  List<ProductModel> orderByProduct = [];
  int orderLength = 0;

  void onChange(String categories) {
    currentCategory = categories;
    orderByProduct = _pruduct.where((e) => e.category == categories).toList();
    orderLength = orderByProduct.length;
    updateChange();
  }

  bool tabBarAction(String name) {
    if (name == currentCategory) return true;
    return false;
  }

  Future<void> loadProduct() async {
    onChangeState(LoadingState.onProcessing);
    var result = await service.getAll();
    _pruduct.clear();
    _pruduct = result!;
    onChangeState(LoadingState.onSuccess);
    updateChange();
  }

  Future<void> loadCatogories() async {
    onChangeState(LoadingState.onProcessing);
    var result = await service.getCategoris();
    _catogories.clear();
    _catogories = result;
    currentCategory = _catogories.first;
    onChangeState(LoadingState.onSuccess);
    updateChange();
  }

  Future<void> loadOrderByCategorie(String categories) async {
    onChangeStateView(LoadingStateView.onProcessing);
    var result = await service.getProCategoris(categories);
    if (result.isEmpty) debugPrint("get data is null");
    _pruduct = result;
    onChangeStateView(LoadingStateView.onSuccess);
    updateChange();
  }
}
