import 'package:flutter/services.dart';
import 'package:manager/manager.dart';

final imageRM = RM.injectFuture(
  () async => Uint8List.sublistView(
    await rootBundle.load('assets/icon.png'),
  ),
);

T? mayBeOf<T extends InheritedWidget>(BuildContext context) {
  return context.dependOnInheritedWidgetOfExactType<T>();
}

T of<T extends InheritedWidget>(BuildContext context) {
  return mayBeOf<T>(context) as T;
}
