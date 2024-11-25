import 'package:ideal_store/dashboard/current_worth.dart';

import '../main.dart';

class DashboardPage extends UI {
  const DashboardPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'Dashboard'.text(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          'Welcome to Ideal Store'.text().pad(),
          currentWorth.text(textScaleFactor: 5).pad(),
          ElevatedButton(
            onPressed: () {
              currentIndex(1);
            },
            child: Text('Go to Products'),
          ).pad(),
          Expanded(
            child: ListView.builder(
              itemCount: productsRM.state.length,
              itemBuilder: (context, index) {
                final product = productsRM.state[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeProduct(product.id);
                    },
                  ),
                  onTap: () {
                    // Edit product
                    navigator.dialog(ProductDialog(product: product));
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              navigator.dialog(ProductDialog());
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class ProductDialog extends StatelessWidget {
  final Product? product;

  const ProductDialog({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController =
        TextEditingController(text: product?.price.toString() ?? '');

    return AlertDialog(
      title: Text(product == null ? 'Add Product' : 'Edit Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // final name = nameController.text;
            // final price = double.tryParse(priceController.text) ?? 0.0;

            // if (product == null) {
            //   productsRM.create(Product(name: name, price: price));
            // } else {
            //   productsRM.update(product!.copyWith(name: name, price: price));
            // }

            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
