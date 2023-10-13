import 'package:flutter/material.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/home_page_controller.dart';
import 'package:flutter_firebase_webscraping/pages/home_page/sub/add_product/add_product.dart';
import 'package:get/get.dart';
import 'package:styled_text/styled_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());

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
            Expanded(
              child: Stack(children: [
                if (controller.list.isEmpty)
                  const Center(
                    child: Text(
                      'No Product',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      children: controller.list.map((product) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFEEEEEE),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StyledText(
                                    text: '<brand>${product.productBrand}</brand> <model>${product.productModel}</model>',
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
                                    product.productDescription,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ).paddingOnly(top: 5),
                                  FutureBuilder<String>(
                                    future: controller.getPrice(product.productUrl),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Text('Loading...',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF000000),
                                            ));
                                      } else if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        return Text(
                                          snapshot.data ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF000000),
                                          ),
                                        );
                                      }
                                    },
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(left: 10)
                            ],
                          ).paddingSymmetric(horizontal: 10),
                          IconButton(
                              onPressed: () {
                                controller.deleteSelectedProduct(product);
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  }).toList()),
                ),
                Positioned(
                  bottom: 25,
                  right: 25,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.to(() => const AddProduct());
                    },
                    elevation: 0,
                    backgroundColor: const Color(0xFF000000),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      );
    });
  }
}
