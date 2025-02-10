import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:ideal_store/products/product.dart';
import 'package:ideal_store/products/product_page.dart';
import 'package:ideal_store/products/products_bloc.dart';
import 'package:manager/manager.dart';

import '../navigator.dart';

class ProductsPage extends UI {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('products'),
        actions: [
          if (authenticationBloc.isAdmin)
            IconButton(
              tooltip: 'add product',
              onPressed: () {
                productsBloc.put(
                  Product(),
                );
              },
              icon: Icon(Icons.add_shopping_cart),
            ).pad(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if (productsBloc.products.isEmpty)
                'no products'
                    .text(
                      textScaleFactor: 2,
                    )
                    .pad(),
              ...productsBloc.products.map(
                (eachProduct) {
                  return ListTile(
                    onTap: () {
                      navigator.to(ProductPage(productID: eachProduct.id));
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
