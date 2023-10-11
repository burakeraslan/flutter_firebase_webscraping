import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final String productBrand;
  @HiveField(1)
  final String productModel;
  @HiveField(2)
  final String productDescription;
  @HiveField(3)
  final String productUrl;

  ProductModel({
    required this.productBrand,
    required this.productModel,
    required this.productDescription,
    required this.productUrl,
  });
}
