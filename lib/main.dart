import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_crud/providers/product_provider.dart';
import 'package:firestore_crud/screens/product.dart';
import 'package:firestore_crud/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider<List<Product>>(
          create: (context) => firestoreService.getProducts(),
          initialData: const [],
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore Crud',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Products(),
      ),
    );
  }
}
