import 'dart:async';

import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/home/orders_page.dart';
import 'package:ideal_store/home/products_page.dart';
import 'package:ideal_store/home/settings_page.dart';
import 'package:ideal_store/home/users/user_page.dart';
import 'package:ideal_store/home/users/users_page.dart';
import 'package:ideal_store/main.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductsRepository productsRepository = depend();

  Iterable<Product> products = [];
  int index = 3;
  Destinations get destination => Destinations.values[index];

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = productsRepository
        .watch()
        .listen((_) => setState(() => products = productsRepository.getAll()));
  }

  void onRandomProductAdded() {
    productsRepository.put(Product());
  }

  void onIndexChanged(int index) {
    setState(() => this.index = index);
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
      appBar: AppBar(
        title: Text(destination.name.toUpperCase()),
      ),
      body: destination.page,
      floatingActionButton: FloatingActionButton(
        onPressed: onRandomProductAdded,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onIndexChanged,
        destinations: [
          for (final page in Destinations.values)
            NavigationDestination(
              icon: Icon(page.icon),
              label: page.label,
            ),
        ],
      ),
    );
  }
}

enum Destinations {
  home,
  orders,
  customers,
  settings,
  profile;

  String get label {
    return switch (this) {
      Destinations.home => 'Home',
      Destinations.orders => 'Orders',
      Destinations.customers => 'Customers',
      Destinations.settings => 'Settings',
      Destinations.profile => 'User',
    };
  }

  IconData get icon {
    return switch (this) {
      Destinations.home => Icons.home,
      Destinations.orders => Icons.shopping_cart,
      Destinations.customers => Icons.people,
      Destinations.settings => Icons.settings,
      Destinations.profile => Icons.person,
    };
  }

  Widget get page {
    return switch (this) {
      Destinations.home => const ProductsPage(),
      Destinations.orders => const OrdersPage(),
      Destinations.customers => const UsersPage(),
      Destinations.settings => const SettingsPage(),
      Destinations.profile => const UserPage(),
    };
  }
}
