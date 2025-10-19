import 'package:ideal_store/utils/repository.dart';
import 'package:objectbox/objectbox.dart';

mixin CRUD<T> on Repository<T> {
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
abstract class CrudRepository<T> = Repository<T> with CRUD<T>;
