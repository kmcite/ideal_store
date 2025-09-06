import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/home/current_worth.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/home/product_dialog.dart';

import 'package:ideal_store/main.dart';
import 'package:ideal_store/shared/utils.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ProductsRepository productsRepository = depend();

  Iterable<Product> products = [];

  onProductRemoved(Product product) {}

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
          currentWorth(products).text(textScaleFactor: 5).pad(),
          ElevatedButton(
            onPressed: () {
              // setIndex(1);
            },
            child: Text('Go to Products'),
          ).pad(),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.elementAt(index);
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onProductRemoved(product),
                  ),
                  onTap: () => navigator.toDialog(
                    ProductDialog(product: product),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
