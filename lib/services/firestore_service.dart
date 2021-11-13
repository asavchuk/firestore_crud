import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/models/product.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future saveProduct(Product p) {
    return _db.collection('products').doc(p.productId).set(p.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList());
  }

  Future removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }
}
