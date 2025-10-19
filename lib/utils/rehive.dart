import 'package:hive_flutter/hive_flutter.dart' show Box;
import 'package:ideal_store/utils/repository.dart';

mixin Rehive<T> on Repository<T> {
  late final hive = this.service<Box>();

  void save(String key, String value) async {
    await hive.put(key, value);
  }

  String get(String key) {
    return hive.get(key);
  }
}
abstract class HiveRepository<T> = Repository<T> with Rehive<T>;
