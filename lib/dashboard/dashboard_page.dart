import 'package:ideal_store/dashboard/current_worth.dart';
import 'package:ideal_store/products/product.dart';
import 'package:ideal_store/products/products_bloc.dart';
import 'package:manager/manager.dart';

import 'package:ideal_store/main.dart';
import 'package:ideal_store/navigator.dart';

class DashboardPage extends UI {
  const DashboardPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'dashboard'.text(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          'Welcome to Ideal Store'.text().pad(),
          currentWorth.text(textScaleFactor: 5).pad(),
          ElevatedButton(
            onPressed: () => appBloc.setIndex(1),
            child: Text('Go to Products'),
          ).pad(),
          Expanded(
            child: ListView.builder(
              itemCount: productsBloc.products.length,
              itemBuilder: (context, index) {
                final product = productsBloc.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      productsBloc.remove(product.id);
                    },
                  ),
                  onTap: () {
                    // Edit product
                    navigator.toDialog(ProductDialog(product: product));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDialog extends UI {
  final Product product;

  const ProductDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: product.name);
    final priceController =
        TextEditingController(text: product.price.toString());

    return AlertDialog(
      title: Text('edit product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'name'),
          ).pad(),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'price'),
            keyboardType: TextInputType.number,
          ).pad(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => navigator.back(),
          child: Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final name = nameController.text;
            final price = int.tryParse(priceController.text) ?? 0;
            productsBloc.put(
              product
                ..name = name
                ..price = price,
            );
            navigator.back();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
