class SectionItem{

  SectionItem({this.image,this.product}); // Construtor p/ fazer clone

  SectionItem.fromMap(Map<String, dynamic> map){
    image = map['image'] as String;
    product = map['product'] as String;
  }

  String image;
  String product;

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }

  SectionItem clone() {
    return SectionItem(
      image: image,
      product: product,
    );
  }
}

