import 'package:ideal_store/objectbox.g.dart';

import 'authentication/authentication.dart';
import 'categories/categories.dart';
import 'main.dart';

export 'dart:convert';

export 'package:colornames/colornames.dart';
export 'package:file_picker/file_picker.dart';
export 'package:flex_color_scheme/flex_color_scheme.dart';
// export 'package:flutter/material.dart' hide Action;
export 'package:flutter/services.dart';
// export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:ideal_store/customers/customer_builder.dart';
export 'package:ideal_store/customers/customer_tile.dart';
export 'package:ideal_store/customers/customer.dart';
export 'package:ideal_store/customers/customer_page.dart';
export 'package:ideal_store/authentication/users_page.dart';
export 'package:ideal_store/dashboard/dashboard_page.dart';
export 'package:ideal_store/orders/orders_page.dart';
export 'package:ideal_store/products/product_builder.dart';
export 'package:ideal_store/products/product_tile.dart';
export 'package:ideal_store/products/product_page.dart';
export 'package:ideal_store/products/products_page.dart';
export 'package:ideal_store/products/product.dart';
export 'package:ideal_store/settings/fonts_ui.dart';
export 'package:ideal_store/settings/material_colors_ui.dart';
export 'package:ideal_store/settings/theme_modes_ui.dart';
export 'package:ideal_store/settings/settings_page.dart';
export 'package:ideal_store/settings/settings.dart';
export 'package:ideal_store/settings/settings_controller.dart';
export 'package:ideal_store/shared/cities.dart';
export 'package:ideal_store/shared/theme.dart';
export 'package:ideal_store/shared/utils.dart';
export 'package:manager/manager.dart' hide Order;
export 'package:path_provider/path_provider.dart';
export 'package:states_rebuilder/states_rebuilder.dart';
export 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final dir = await getApplicationDocumentsDirectory();
  store = await openStore(
    directory: path.join(dir.path, appInfo.appName),
  );
  await RM.storageInitializer(HiveStorage());
  runApp(IdealStoreApp());
}

class IdealStoreApp extends TopUI {
  const IdealStoreApp({super.key});

  String? get fontFamily {
    try {
      return GoogleFonts.getFont(settingsRM.font()).fontFamily;
    } catch (e) {
      return null;
    }
  }

  @override
  get themeMode => settingsRM.themeMode();
  @override
  ThemeData get theme => FlexThemeData.light(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: settingsRM.materialColor(),
        ),
        fontFamily: fontFamily,
      );

  @override
  ThemeData get darkTheme => FlexThemeData.dark(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: settingsRM.materialColor(),
          brightness: Brightness.dark,
        ),
        fontFamily: fontFamily,
      );

  @override
  Widget home(BuildContext context) {
    FlutterNativeSplash.remove();
    return isAuthenticated ? HomeApp() : AuthenticationPage();
  }
}

class HomeApp extends UI {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex(),
            onDestinationSelected: (index) => currentIndex(index),
            labelType: NavigationRailLabelType.all,
            destinations: [
              ...NavigationTargets.values.where(
                (target) {
                  return target != NavigationTargets.admin || isAdmin;
                },
              ).map(
                (target) {
                  return NavigationRailDestination(
                    icon: Icon(target.icon),
                    label: Text(target.label),
                  );
                },
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: currentIndex(),
              children: NavigationTargets.values
                  .where(
                    (target) {
                      return target != NavigationTargets.admin ||
                          currentUser.role == Role.admin;
                    },
                  )
                  .map(
                    (target) => target.page,
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

final indexRM = rms(0);
int currentIndex([int? i]) {
  if (i != null) indexRM.state = i;
  return indexRM.state;
}

enum NavigationTargets {
  dashboard,
  products,
  categories,
  settings,
  admin,
}

extension on NavigationTargets {
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
