import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_webscraping/models/product_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

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

  Future<String> getPrice(String url) async {
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final priceElement = document.querySelector('.cBVHJG'); // 23.519,00 TL
        if (priceElement != null) {
          final priceText = priceElement.text;
          return priceText;
        } else {
          // if the price is not found, it tries again
          return getPrice(url);
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
