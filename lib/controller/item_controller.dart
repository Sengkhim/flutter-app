import '../domain/item_model.dart';
import 'base_controller.dart';

class ItemController extends BaseController {
  final List<ItemModel> _itemListCard = <ItemModel>[];
  List<ItemModel> get itemListCard => _itemListCard;
  String get currentCard => _itemListCard.length.toString();

  Map<String, List<ItemModel>> itemMapping = {};
  Map<String, List<ItemModel>> tempItemMapping = {};

  void addItemToCard(String item, ItemModel itemModel) {
    _itemListCard.add(itemModel);
    // tempItemMapping.addAll({item: _itemListCard});
    itemMapping.addAll({item: tempItemMapping[item]!});
    updateChange();
  }

  String currentQtyItem(String itemName) {
    return itemMapping[itemName] == null
        ? "1"
        : itemMapping[itemName]!
            .where((element) => element.name == itemName)
            .toList()
            .length
            .toString();
  }

  void removeItemFormCard(ItemModel item) {
    // _itemListCard.remove(itemId);
    itemMapping[item]!.remove(item);
    updateChange();
  }
}
