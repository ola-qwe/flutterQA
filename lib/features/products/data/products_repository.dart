import 'package:flutter_qa/constants/test_products.dart';
import 'package:flutter_qa/features/products/domain/product.dart';

class ProductsRepository {
  ProductsRepository._();
  static ProductsRepository instance = ProductsRepository._();

  final _products = kTestProducts;

  List<Product> getProducts() {
    return _products;
  }

  Product getProductById(String productId) {
    return  _products.firstWhere((product) => product.id == productId);
  }

}
