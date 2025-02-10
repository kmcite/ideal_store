import 'package:ideal_store/products/product.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'products_repository.dart';

class ProductsBloc {
  ProductsRepository get _productsRepository => productsRepository;

  late final productsRM = RM.inject(() => _productsRepository.getAll());

  List<Product> get products => productsRM.state;

  void put(Product product) {
    _productsRepository.put(product);
    productsRM.stateAsync = _productsRepository.getAllAsync();
  }

  void remove(int id) {
    _productsRepository.remove(id);
    productsRM.stateAsync = _productsRepository.getAllAsync();
  }

  Product? get(int productID) => _productsRepository.get(productID);
  late final removeAll = _productsRepository.removeAll;
}

final productsBloc = ProductsBloc();
