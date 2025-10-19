import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/features/home/destinations.dart';
import 'package:ideal_store/main.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductsRepository productsRepository = depend();

  /// GLOBAL STATE
  Iterable<Product> get products => productsRepository.getAll();

  /// LOCAL STATE
  int index = 3;
  Destinations get destination => Destinations.values[index];

  void onRandomProductAdded() {
    productsRepository.put(Product());
  }

  void onIndexChanged(int index) {
    setState(() => this.index = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: destination.page,
      bottomNavigationBar: FBottomNavigationBar(
        index: index,
        onChange: onIndexChanged,
        children: [
          for (final page in Destinations.values)
            FBottomNavigationBarItem(
              icon: Icon(page.icon),
              label: Text(page.label),
            ),
        ],
      ),
    );
  }
}
