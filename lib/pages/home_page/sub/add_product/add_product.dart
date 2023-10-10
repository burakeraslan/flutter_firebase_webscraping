import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/sub/add_product/add_product_controller.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());
    return GetBuilder<AddProductController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: const Color(0xFFFF4D4D),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ).paddingSymmetric(horizontal: 5),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    List<QueryDocumentSnapshot> phoneSnapshots = await controller.getPhones();

                    for (var phoneSnapshot in phoneSnapshots) {
                      String description = phoneSnapshot["description"];
                      print("Description: $description");
                    }
                  },
                  child: const Text('tıklat')),
            )
          ],
        ),
      );
    });
  }
}
