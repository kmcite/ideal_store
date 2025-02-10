import 'package:ideal_store/dashboard/dashboard_page.dart';
import 'package:ideal_store/products/products_page.dart';
import 'package:ideal_store/settings/settings_page.dart';
import 'package:ideal_store/users/users_page.dart';
import 'package:manager/manager.dart';

import 'categories/categories.dart';

/// is a bloc as well as repository object
final navigator = RM.navigate;

enum NavigationTargets {
  dashboard,
  products,
  categories,
  settings,
  admin;

  bool get isAdmin => this == NavigationTargets.admin;
  bool get isNotAdmin => !isAdmin;

  Widget get page => switch (this) {
        NavigationTargets.dashboard => DashboardPage(),
        NavigationTargets.products => ProductsPage(),
        NavigationTargets.categories => CategoriesUI(),
        NavigationTargets.settings => SettingsPage(),
        NavigationTargets.admin => UsersPage(),
      };
  String get label => switch (this) {
        NavigationTargets.dashboard => 'Dashboard',
        NavigationTargets.products => 'Products',
        NavigationTargets.categories => 'Categories',
        NavigationTargets.settings => 'Settings',
        NavigationTargets.admin => 'Admin',
      };
  IconData get icon => switch (this) {
        NavigationTargets.dashboard => Icons.dashboard,
        NavigationTargets.products => Icons.production_quantity_limits,
        NavigationTargets.categories => Icons.category,
        NavigationTargets.settings => Icons.settings,
        NavigationTargets.admin => Icons.admin_panel_settings,
      };
}

// class AppRoutInformationParser
//     extends RouteInformationParser<RouteInformation> {
//   @override
//   Future<RouteInformation> parseRouteInformation(routeInformation) async {
//     return RouteInformation(uri: Uri.parse(routeInformation.location));
//   }

//   @override
//   RouteInformation restoreRouteInformation(RouteInformation routeInformation) {
//     return RouteInformation(uri: Uri.parse(routeInformation.location));
//   }
// }

// class AppDelegate extends RouterDelegate<RouteInformation>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       pages: [],
//     );
//   }

//   @override
//   final navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   Future<void> setNewRoutePath(RouteInformation configuration) {
//     throw UnimplementedError();
//   }
// }
