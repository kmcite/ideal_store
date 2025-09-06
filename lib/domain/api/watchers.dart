import 'dart:async';

import 'package:flutter/material.dart' as m;
import 'package:ideal_store/domain/api/repository.dart';
import 'package:ideal_store/navigator.dart';

import '../../main.dart';

mixin Watchers<T> on Repository<T> {
  Map<int, T> get items;
  Stream<T> watch(int id) {
    return controller.stream.map((event) => items[id]!);
  }

  Stream<Iterable<T>> watchAll() {
    return controller.stream.map((event) => items.values);
  }

  void notfiyListeners() {
    controller.add(items.values);
  }

  final controller = StreamController<Iterable<T>>.broadcast();
}

mixin _Bloc<W extends StatefulWidget> on m.State<W> {
  T depend<T extends Repository>() {
    try {
      return repositories[T] as T;
    } catch (e) {
      throw Exception('Repository ${T} not found');
    }
  }

  void listener(_) {
    if (mounted) setState(() {});
  }

  NavigationRepository get navigator => depend();
  GlobalKey<NavigatorState> get key => navigator.key;
}
abstract class State<U extends StatefulWidget> = m.State<U> with _Bloc<U>;
