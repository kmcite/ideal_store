import 'package:ideal_store/main.dart';

class ProductsPage extends UI {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('PRODUCTS'),
        actions: [
          IconButton(
            tooltip: 'Add Product',
            onPressed: () {
              products(Product());
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
              if (products().isEmpty)
                'No products'
                    .text(
                      textScaleFactor: 2,
                    )
                    .pad(),
              ...products().map(
                (eachProduct) {
                  return ListTile(
                    // productID: eachProduct.id,
                    // size: size,
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
