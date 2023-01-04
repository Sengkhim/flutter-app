import '../domain/item_model.dart';
import 'base_controller.dart';

class ItemController extends BaseController {
  final List<ItemModel> _itemListCard = <ItemModel>[];
  List<ItemModel> get itemListCard => _itemListCard;
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

  String? currentQtyItem(String id) {
    int indexer = ItemModel.itemList.indexWhere((element) => element.id == id);
    if (_itemListCard.isEmpty) {
      return "1";
    }
    var result = ItemModel.itemList[indexer].qty!.value;
    return result.toString();
  }

  void removeItemFormCard(ItemModel item) {
    // _itemListCard.remove(itemId);
    // tempItemMapping[item]!.remove(item);
    updateChange();
  }
}
