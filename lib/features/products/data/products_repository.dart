import 'package:flutter_qa/constants/test_products.dart';
import 'package:flutter_qa/features/products/domain/product.dart';
import 'package:flutter_qa/utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsRepository {
  ProductsRepository({this.isDelay=true});
  final bool isDelay;

  final _products = kTestProducts;

  List<Product> getProducts() {
    return _products;
  }

  Product? getProductById(String productId) {
    return _getProductById(_products, productId);
  }

  Future<List<Product>> getFutureProducts() async {
    await delay(isDelay);
    return Future.value(_products);
  }

  Stream<List<Product>> getStreamProducts() async* {
    await delay(isDelay);
    yield _products;
  }

  Stream<Product?> getStreamProductById(String productId) {
    return getStreamProducts()
        .map((product) => _getProductById(product, productId));
  }

  static Product? _getProductById(List<Product> products, String id) {
    try {
      return
      products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
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

final productDetailsStreamProvider =
    StreamProvider.autoDispose.family<Product?, String>(
  (ref, id) {
    final repo = ref.watch(productRepoProvider);
    return repo.getStreamProductById(id);
  },
);
