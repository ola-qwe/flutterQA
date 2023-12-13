import 'package:flutter_qa/constants/test_products.dart';
import 'package:flutter_qa/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsRepository {
  final _products = kTestProducts;

  List<Product> getProducts() {
    return _products;
  }

  Product getProductById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  Future<List<Product>> getFutureProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> getStreamProducts() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product> getStreamProductById(String productId) {
    return Stream.value(_products).map(
        (product) => product.firstWhere((product) => product.id == productId));
  }
}

final productRepoProvider = Provider<ProductsRepository>(
  (ref) {
    return ProductsRepository();
  },
);

final productProvider = Provider<List<Product>>(
  (ref) {
    final repo = ref.watch(productRepoProvider);
    return repo.getProducts();
  },
);

final productStreamProvider = StreamProvider.autoDispose<List<Product>>(
  (ref) {
    final repo = ref.watch(productRepoProvider);
    return repo.getStreamProducts();
  },
);

final productFutureProvider = FutureProvider.autoDispose<List<Product>>(
  (ref) {
    final repo = ref.watch(productRepoProvider);
    return repo.getFutureProducts();
  },
);

final productDetailsStreamProvider = StreamProvider.autoDispose.family<Product, String>(
  (ref, id) {
    final repo = ref.watch(productRepoProvider);
    return repo.getStreamProductById(id);
  },
);
