// import 'package:flutter/material.dart';
// import 'package:ideal_store/app/modules/home/views/dashboard/dashboard_page.dart';
// import 'package:ideal_store/app/modules/products/views/products/products_page.dart';
// import 'package:ideal_store/app/modules/settings/views/settings/settings_page.dart';
// import 'package:ideal_store/app/modules/users/views/users/users_page.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:ideal_store/domain/api/repository.dart';
import 'package:ideal_store/main.dart';
import 'package:navigation_builder/navigation_builder.dart';

class NavigationRepository extends Repository<int> {
  final navigator = NavigationBuilder.navigate;
  late final key = navigator.navigatorKey;

  void toReplacement(Widget page) {
    navigator.toReplacement(page);
  }

  void to(Widget page) {
    navigator.to(page);
  }

  void toDialog(Widget page) {
    navigator.toDialog(page);
  }

  void back() {
    navigator.back();
  }
}
