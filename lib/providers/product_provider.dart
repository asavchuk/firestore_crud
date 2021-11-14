import 'package:firestore_crud/models/product.dart';
import 'package:firestore_crud/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  late String _name;
  late String _productId;
  late double _price;
  var uuid = const Uuid();

  var _error = '';

  loadValues(Product product) {
    _name = product.name;
    _productId = product.productId;
    _price = product.price;
  }

//Getters
  String get name => _name;
  double get price => _price;
  String get error => _error;

//Setters
  changeName(String value) {
    _name = value.trim();
    validate();
  }

  changePrice(String value) {
    try {
      _price = double.parse(value);
    } catch (e) {
      _price = 0;
    } finally {
      validate();
    }
  }

  changeError(String value) {
    _error = value;
    notifyListeners();
  }

  bool saveProduct() {
    if (_productId == '') {
      //Save new
      firestoreService.saveProduct(
        Product(name: name, price: price, productId: uuid.v4()),
      );
    } else {
      //Update
      firestoreService.saveProduct(
        Product(name: name, price: _price, productId: _productId),
      );
    }

    changeError('');
    return true;
  }

  bool validate() {
    if (_name.trim().isEmpty) {
      _error = 'Name is empty';
      notifyListeners();
      return false;
    }

    if (_price <= 0) {
      _error = 'Wrong price';
      notifyListeners();
      return false;
    }

    _error = '';
    return true;
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
