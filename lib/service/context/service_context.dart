import 'package:cool_app/interceptors/main_interceptors.dart';
import 'package:cool_app/service/end_point.dart';
import 'package:dio/dio.dart';

class ServiceContext implements BaseServiceContext {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: defEndPoint,
    // connectTimeout: 5000,
    // receiveTimeout: 3000,
  );
  static final header = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  static final Options _options = Options(headers: header);
  static BaseOptions get options => _baseOptions;
  final Dio _dio = Dio(options);
  Dio get http {
    _dio.interceptors.add(MainInterceptors());
    return _dio;
  }

  @override
  Future<List<dynamic>> getAll({String? endPoint}) async {
    Response response = await http.get(endPoint!, options: _options);
    if (response.statusCode == 200) {
      var res = response.data["products"] as List;
      return res;
    }
    return [];
  }

  Future<List<dynamic>> getAlls({String? endPoint}) async {
    Response response = await http.get(endPoint!, options: _options);
    if (response.statusCode == 200) {
      var res = response.data as List;
      return res;
    }
    return [];
  }
}

abstract class BaseServiceContext {
  Future<List<dynamic>> getAll({String? endPoint});
}
