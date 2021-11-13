import 'package:firestore_crud/models/edit_product.dart';
import 'package:firestore_crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 30.0),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProduct(Product(productId: '', name: '', price: 0)),
                ),
              );
            },
          ),
        ],
      ),
      body: (products != null)
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name),
                  trailing: Text(products[index].price.toString()),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProduct(products[index])));
                  },
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
