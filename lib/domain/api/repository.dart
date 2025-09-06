import 'dart:async';
import 'dart:developer' show log;

import 'package:hive_flutter/hive_flutter.dart' show Box;
import 'package:objectbox/objectbox.dart' hide Box;

abstract class Repository<T> {
  S service<S>() {
    try {
      log('${S} serves $runtimeType');
      return services[S] as S;
    } catch (e) {
      throw 'Service ${S} not found for $runtimeType';
    }
  }
}

final repositories = <Type, Repository>{};
void repository<T extends Repository>(T instance) {
  repositories[T] = instance;
  log('Repository | ${T}');
}

final services = <Type, dynamic>{};

void service<T>(T instance) {
  if (instance is Future || instance is Stream) {
    throw 'Can not service a Future or Stream';
  }
  services[T] = instance;
  log('Service | ${T}');
}

abstract class CrudRepository<T> = Repository<T> with CRUD<T>;
abstract class HiveRepository = Repository with Rehive;

mixin Rehive on Repository {
  late final box = this.service<Box>();

  void save(String key, String value) async {
    await box.put(key, value);
  }

  String get(String key) {
    return box.get(key);
  }
}

mixin CRUD<T> on Repository<T> {
  final controller = StreamController<int>.broadcast();
  Stream<int> watch() => controller.stream;

  notify() {
    controller.add(1);
  }

  late final store = this.service<Store>();
  late final box = store.box<T>();

  T? get(int id) => box.get(id);
  List<T> getAll() => box.getAll();
  int count() => box.count();

  void put(T any) {
    box.put(any);
    notify();
  }

  void remove(T item) {
    final id = (item as dynamic).id;
    box.remove(id);
    notify();
  }

  void removeAll() {
    box.removeAll();
    notify();
  }
}
