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
}
