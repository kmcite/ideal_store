import 'dart:async';

import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/home/product_page.dart';
import 'package:ideal_store/shared/utils.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsRepository productsRepository = depend();

  late Iterable<Product> products = productsRepository.getAll();

  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = productsRepository.watch().listen(
          (_products) => setState(() => products = productsRepository.getAll()),
        );
  }

  void onProductSaved(Product product) {
    productsRepository.put(product);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('products'),
      //   actions: [
      //     if (authenticationBloc.isAdmin)
      //       IconButton(
      //         tooltip: 'add product',
      //         onPressed: () => onProductSaved(Product()),
      //         icon: Icon(Icons.add_shopping_cart),
      //       ).pad(),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if (products.isEmpty)
                'no products'
                    .text(
                      textScaleFactor: 2,
                    )
                    .pad(),
              ...products.map(
                (eachProduct) {
                  return ListTile(
                    onTap: () {
                      navigator.to(ProductPage(product: eachProduct));
                    },
                    title: eachProduct.brandIndex.text(),
                    subtitle: eachProduct.name.text(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
