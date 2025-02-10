import 'package:states_rebuilder/states_rebuilder.dart';

import 'categories.dart';
import 'categories_repository.dart';

class CategoriesBloc {
  CategoriesRepository get _categoriesRepository => categoriesRepository;

  late final categoriesRM = RM.inject(
    () => _categoriesRepository.getAll(),
  );
  List<Category> get categories => categoriesRM.state;

  void put(Category category) {
    _categoriesRepository.put(category);
    categoriesRM.stateAsync = _categoriesRepository.getAllAsync();
  }

  void remove(int id) {
    _categoriesRepository.remove(id);
    categoriesRM.stateAsync = _categoriesRepository.getAllAsync();
  }
}

final CategoriesBloc categoriesBloc = CategoriesBloc();
