import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_webscraping/models/product_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePageController extends GetxController {
  final box = Hive.box<ProductModel>('productList');
  List<ProductModel> get list => box.values.toList();

  void deleteSelectedProduct(ProductModel product) {
    box.deleteAt(list.indexOf(product));
    var url = product.productUrl;
    FirebaseFirestore.instance.collection('phones').where('url', isEqualTo: url).get().then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance.collection('phones').doc(element.id).update({'selected': false});
      }
    });
    update();
  }

  // deneme
  void addProduct(String brand, String model, String description, String url) {
    box.add(
      ProductModel(
        productBrand: brand,
        productModel: model,
        productDescription: description,
        productUrl: url,
      ),
    );
    update();
  }
}
