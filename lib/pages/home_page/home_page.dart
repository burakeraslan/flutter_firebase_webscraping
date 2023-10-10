import 'package:flutter/material.dart';
import 'package:flutter_firebase_webscraping/models/product_model.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/home_page_controller.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/sub/add_product/add_product.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    final box = Hive.box<ProductModel>('products');

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
              onPressed: () async {
                Get.to(() => const AddProduct());
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
