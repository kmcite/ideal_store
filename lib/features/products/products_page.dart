import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/categories_repository.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/category.dart';
import 'package:ideal_store/features/products/dialogs/new_product_dialog.dart';
import 'package:ideal_store/features/products/product_tile.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/utils/extensions.dart';

import '../home/current_worth.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsRepository productsRepository = depend();
  late AuthenticationRepository authenticationRepository = depend();
  late CategoriesRepository categoriesRepository = depend();

  Iterable<Product> get products => productsRepository.getAll();
  Iterable<Category> get categories => categoriesRepository.getAll();
  bool get admin => authenticationRepository.admin;

  void onNewProductDialogOpened() => navigator.toDialog(NewProductDialog());

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Products'),
        suffixes: [
          if (admin)
            FHeaderAction(
              onPress: onNewProductDialogOpened,
              icon: Icon(Icons.add_shopping_cart),
            ),
        ],
      ),
      child: SafeArea(
        child: Column(
          spacing: 8,
          children: [
            'Welcome to Ideal Store'.text(textScaleFactor: 2).pad(),
            Text(currentWorth(products)),
            if (products.isEmpty) 'No products'.text(textScaleFactor: 2),
            Text('Categories'),
            categories.length.text(textScaleFactor: 3),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, i) {
                  final product = products.elementAt(i);
                  return ProductTilev2(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
