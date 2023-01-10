import 'package:cool_app/domain/product_model.dart';
import 'package:cool_app/service/end_point.dart';
import 'package:flutter/cupertino.dart';
import '../repository/repository.dart';
import 'context/service_context.dart';

class ProductServerice implements IRepository<ProductModel> {
  ProductServerice({required ServiceContext context}) {
    _context = context;
  }
  late ServiceContext _context;
  final String endpoint = "https://dummyjson.com/products/category/";
  @override
  Future<List<ProductModel>>? getAll() async {
    try {
      var response = await _context.getAll(endPoint: defEndPoint);
      List<ProductModel> result =
          response.map((e) => ProductModel.fromJson(e)).toList();
      return result;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCategoris() async {
    try {
      var response =
          await _context.http.get("https://dummyjson.com/products/categories");
      if (response.statusCode == 200) {
        return response.data;
      }
      return [];
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProCategoris(String categories) async {
    try {
      var response = await _context.getAll(endPoint: endpoint + categories);
      List<ProductModel> result =
          response.map((e) => ProductModel.fromJson(e)).toList();
      return result;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  @override
  Future<ProductModel> create(ProductModel entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> delete(ProductModel entity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> findByExpression(
      bool Function(ProductModel entity) expression) {
    // TODO: implement findByExpression
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> update(ProductModel entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
