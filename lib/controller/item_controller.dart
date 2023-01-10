import '../domain/item_model.dart';
import 'base_controller.dart';

class ItemController extends BaseController {
  final List<ItemModel> _itemListCard = <ItemModel>[];
  List<ItemModel> _tempListCart = <ItemModel>[];
  List<ItemModel> get itemListCard => _itemListCard;
  List<ItemModel> get tempListCart => _tempListCart;
  String get currentCard => _itemListCard.length.toString();
  num counter = 1;

  Future<void> addItemToCard(String? id, ItemModel itemModel) async {
    int indexer = ItemModel.itemList.indexWhere((element) => element.id == id);
    ItemModel.itemList[indexer].qty!.value =
        ItemModel.itemList[indexer].qty!.value + 1;
    var resutl = ItemModel.itemList.firstWhere((element) => element.id == id);
    _itemListCard.add(resutl);
    counter++;
    updateChange();
  }

  void submitedCart(List<ItemModel> item) {
    _tempListCart = item;
    updateChange();
  }

  String? currentQtyItem(String id) {
    int indexer = ItemModel.itemList.indexWhere((element) => element.id == id);
    if (_itemListCard.isEmpty) {
      return "1";
    }
    var result = ItemModel.itemList[indexer].qty!.value == 0
        ? num.parse("1")
        : ItemModel.itemList[indexer].qty!.value;
    return result.toString();
  }

  void removeItemFormCard(ItemModel item) {
    int indexer = _itemListCard.indexWhere((e) => e.id == item.id);
    if (_itemListCard[indexer].qty!.value > 1) {
      _itemListCard[indexer].qty!.value = _itemListCard[indexer].qty!.value - 1;
      updateChange();
    }
  }
}
