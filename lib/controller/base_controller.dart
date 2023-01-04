import 'package:flutter/material.dart';

import '../reposity/dispose.dart';

class BaseController with ChangeNotifier implements IDisposeable {
  void updateChange() {
    notifyListeners();
  }

  @override
  Future<void> disposeable() {
    throw UnimplementedError();
  }
}
