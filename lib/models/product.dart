class Product {
  final String name;
  final String productId;
  final double price;

  Product({
    required this.name,
    required this.productId,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "productId": productId,
      "price": price,
    };
  }

  Product.fromFirestore(Map firestore)
      : name = firestore['name'],
        productId = firestore['productId'],
        price = firestore['price'];
}
