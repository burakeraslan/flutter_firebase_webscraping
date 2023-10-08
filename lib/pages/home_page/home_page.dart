import 'package:flutter/material.dart';
import 'package:flutter_firebase_webscraping/models/product_model.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    // 'products' box'ına erişmek için
    final box = Hive.box<ProductModel>('products');
    final product = ProductModel(productModel: 'productModel', productDescription: 'productDescription', productUrl: 'productUrl');

    return GetBuilder<HomePageController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: const Color(0xFFFF4D4D),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                // box.add(product);
                // print(box.getAt(0)?.productModel);
              },
              elevation: 0,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      );
    });
  }
}
