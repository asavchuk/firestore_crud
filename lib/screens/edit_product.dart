import 'package:firestore_crud/models/product.dart';
import 'package:firestore_crud/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  const EditProduct(this.product, {Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.product.productId == '') {
      //New Record
      nameController.text = '';
      priceController.text = '';
      Future.delayed(
        Duration.zero,
        () {
          final productProvider = Provider.of<ProductProvider>(context, listen: false);
          productProvider.changeError('');
          productProvider.loadValues(widget.product);
        },
      );
    } else {
      //Controller Update
      nameController.text = widget.product.name;
      priceController.text = widget.product.price.toString();
      //State Update
      Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Product Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(hintText: 'Product Price'),
              onChanged: (value) => productProvider.changePrice(value),
            ),
            productProvider.error.isNotEmpty
                ? Text(productProvider.error, style: const TextStyle(color: Colors.red))
                : const SizedBox(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                if (productProvider.validate()) {
                  productProvider.saveProduct();
                  Navigator.of(context).pop();
                }
              },
            ),
            (widget.product.productId != '')
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red.shade300),
                        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white))),
                    child: const Text('Delete'),
                    onPressed: () {
                      productProvider.removeProduct(widget.product.productId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
