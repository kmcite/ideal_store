import '../main.dart';
import 'categories.dart';

class CategoriesRepository {
  final _categories = store.box<Category>();
  late final getAll = _categories.getAll;
  late final getAllAsync = _categories.getAllAsync;
  late final put = _categories.put;
  late final remove = _categories.remove;
  late final removeAll = _categories.removeAll;
}

final categoriesRepository = CategoriesRepository();
