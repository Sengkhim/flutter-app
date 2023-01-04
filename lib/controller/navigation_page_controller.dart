import 'base_controller.dart';

class NavigationController extends BaseController {
  num _currentPage = 0;
  num get currentPage => _currentPage;

  void onChangePage(num index) {
    _currentPage = index;
    updateChange();
  }
}
