import '../base_controller.dart';

class WidgetBuilderController extends BaseController {
  num _currentPage = 0;
  num get currentPage => _currentPage;
  bool visible = false;

  void visibility(bool value) {
    visible = value;
    updateChange();
  }

  void onChangePage(num index) {
    _currentPage = index;
    updateChange();
  }
}
