import 'package:forui/forui.dart';
import 'package:ideal_store/features/orders/orders_page.dart';
import 'package:ideal_store/features/products/products_page.dart';
import 'package:ideal_store/features/settings/settings_page.dart';
import 'package:ideal_store/features/users/profile/user_profile.dart';
import 'package:ideal_store/features/users/users_page.dart';
import 'package:ideal_store/main.dart';

enum Destinations {
  dashboard,
  orders,
  customers,
  settings,
  profile;

  String get label {
    return switch (this) {
      Destinations.dashboard => 'Home',
      Destinations.orders => 'Orders',
      Destinations.customers => 'Customers',
      Destinations.settings => 'Settings',
      Destinations.profile => 'User',
    };
  }

  IconData get icon {
    return switch (this) {
      Destinations.dashboard => FIcons.house,
      Destinations.orders => FIcons.store,
      Destinations.customers => FIcons.user,
      Destinations.settings => FIcons.settings,
      Destinations.profile => FIcons.userCog,
    };
  }

  Widget get page {
    return switch (this) {
      Destinations.dashboard => const ProductsPage(),
      Destinations.orders => const OrdersPage(),
      Destinations.customers => const UsersPage(),
      Destinations.settings => const SettingsPage(),
      Destinations.profile => const UserPage(),
    };
  }
}
