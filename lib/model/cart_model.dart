class Product {
  int? id;
  String? imageURL;
  int? price;
  String? oldPrice;
  String? name;
  String? category;

  Product(
      {this.imageURL,
      required this.id,
      this.category,
      required this.price,
      this.oldPrice,
      this.name});

  Product.fromjson(Map<String, dynamic> json) {
    imageURL = json['imageURL'];
    name = json['name'];
    id = json[id];
    category = json['category'];
    oldPrice = json['oldPrice'];
    price = json['price'];
  }
}
