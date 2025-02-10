import 'package:ideal_store/main.dart';
import 'package:ideal_store/products/product.dart';

class ProductsRepository {
  final _products = store.box<Product>();
  late final getAllAsync = _products.getAllAsync;
  late final getAll = _products.getAll;
  late final get = _products.get;
  late final removeAll = _products.removeAll;
  late final remove = _products.remove;
  late final put = _products.put;
}

final productsRepository = ProductsRepository();
// ProductsRepository get _productsRepository => productsRepository;
