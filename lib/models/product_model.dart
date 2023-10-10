import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final String productModel;
  @HiveField(1)
  final String productDescription;
  @HiveField(2)
  final String productUrl;

  ProductModel({
    required this.productModel,
    required this.productDescription,
    required this.productUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productModel: json['model'],
      productDescription: json['description'],
      productUrl: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': productModel,
      'description': productDescription,
      'url': productUrl,
    };
  }
}
