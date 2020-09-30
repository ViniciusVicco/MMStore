class ItemSize{
  String name;
  num price;
  int stock;

  ItemSize();

  bool get hasStock => stock > 0;

  ItemSize.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }


  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}