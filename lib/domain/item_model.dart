class ItemModel {
  final String? id;
  final String? name;
  final String? description;
  final num? qty;
  final num? price;
  final String? image;

  ItemModel(
      {this.id, this.name, this.description, this.qty, this.price, this.image});

  static List<ItemModel> itemList = [
    ItemModel(
        id: "1111",
        name: "Iced Lattle",
        image:
            "https://fastly.4sqi.net/img/general/600x600/5055791_kN2Ro9yNlLZs0m1atJshP-gPElrsK6pfhjoPuY_lKt8.jpg",
        description: "The best Cold drink.",
        qty: 1,
        price: 3.15),
    ItemModel(
        id: "222",
        name: "Iced Cuppocino",
        image:
            "https://fastly.4sqi.net/img/general/600x600/5055791_kN2Ro9yNlLZs0m1atJshP-gPElrsK6pfhjoPuY_lKt8.jpg",
        description: "The best Cold drink.",
        qty: 1,
        price: 3.25),
    ItemModel(
        id: "3333",
        name: "Iced Caremel Latte",
        image:
            "https://fastly.4sqi.net/img/general/600x600/5055791_kN2Ro9yNlLZs0m1atJshP-gPElrsK6pfhjoPuY_lKt8.jpg",
        description: "The best Cold drink.",
        qty: 1,
        price: 3.55),
    ItemModel(
        id: "4444",
        name: "Iced Green Tea",
        image:
            "https://fastly.4sqi.net/img/general/600x600/5055791_kN2Ro9yNlLZs0m1atJshP-gPElrsK6pfhjoPuY_lKt8.jpg",
        description: "The best Cold drink.",
        qty: 1,
        price: 3.5),
    ItemModel(
        id: "5555",
        name: "Iced Red Tea",
        image:
            "https://fastly.4sqi.net/img/general/600x600/5055791_kN2Ro9yNlLZs0m1atJshP-gPElrsK6pfhjoPuY_lKt8.jpg",
        description: "The best Cold drink.",
        qty: 1,
        price: 3.65),
    ItemModel(
        id: "1111",
        name: "Iced Test",
        image:
            "https://fastly.4sqi.net/img/general/600x600/5055791_kN2Ro9yNlLZs0m1atJshP-gPElrsK6pfhjoPuY_lKt8.jpg",
        description: "The best Cold drink.",
        qty: 1,
        price: 3.12)
  ];
}
