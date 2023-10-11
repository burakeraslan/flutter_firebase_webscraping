import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_webscraping/models/product_model.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/sub/add_product/add_product_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:styled_text/styled_text.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());
    final box = Hive.box<ProductModel>('products');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          'Select',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF000000),
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF000000),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("phones").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: snapshot.data?.docs.map<Widget>((document) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StyledText(
                                    text: '<brand>${document['brand']}</brand> <model>${document['model']}</model>',
                                    tags: {
                                      'brand': StyledTextTag(
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      'model': StyledTextTag(
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    },
                                  ),
                                  Text(
                                    document['description'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ).paddingOnly(top: 5),
                                ],
                              ),
                              Checkbox(
                                value: document['selected'],
                                onChanged: (value) {
                                  FirebaseFirestore.instance.collection("phones").doc(document.id).update({'selected': value});
                                  if (!document['selected']) {
                                    Get.snackbar(
                                      'Success',
                                      'Added ${document['brand']} ${document['model']}',
                                      backgroundColor: const Color(0xFF00C853),
                                      colorText: const Color(0xFFFFFFFF),
                                    );
                                    box.add(
                                      ProductModel(
                                        productBrand: document['brand'],
                                        productModel: document['model'],
                                        productDescription: document['description'],
                                        productUrl: document['url'],
                                      ),
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Removed',
                                      'Removed ${document['brand']} ${document['model']}',
                                      backgroundColor: const Color(0xFFFF5722),
                                      colorText: const Color(0xFFFFFFFF),
                                    );
                                    box.deleteAt(
                                      box.values.toList().indexWhere((element) => element.productUrl == document['url']),
                                    );
                                  }
                                },
                                activeColor: const Color(0xFFFFFFFF),
                                checkColor: const Color(0xFF000000),
                                shape: const CircleBorder(),
                                side: const BorderSide(
                                  color: Color(0xFF000000),
                                  width: 1,
                                ),
                                splashRadius: 0,
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            color: const Color(0xFF666666),
                          ).paddingOnly(top: 5),
                        ],
                      ).paddingSymmetric(vertical: 5);
                    }).toList() ??
                    <Widget>[
                      const Center(
                        child: Text(
                          'No data',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
              ).paddingSymmetric(horizontal: 20),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
