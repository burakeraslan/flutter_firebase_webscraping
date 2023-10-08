import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_webscraping/firebase_options.dart';
import 'package:flutter_firebase_webscraping/models/product_model.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Directory appDocDir = await getApplicationCacheDirectory();
  await Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter<ProductModel>(ProductModelAdapter());
  await Hive.openBox<ProductModel>('products');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
