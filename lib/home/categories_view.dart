import 'package:ideal_store/domain/api/categories_repository.dart';
import 'package:ideal_store/domain/models/categories.dart';
import 'package:ideal_store/shared/utils.dart';

import '../main.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late CategoriesRepository categoriesRepository = depend();

  Iterable<Category> categories = [];
  bool admin = false;

  void putCategory(Category category) {}
  void deleteCategory(Category category) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories.elementAt(index);
          return ListTile(
            title: admin
                ? TextFormField(
                    initialValue: category.name,
                    onChanged: (value) {
                      putCategory(category..name = value);
                    },
                  )
                : FilledButton(
                    onPressed: () {},
                    child: category.name.text(),
                  ),
            trailing: admin
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteCategory(category),
                  )
                : null,
          );
        },
      ),
      floatingActionButton: admin
          ? FloatingActionButton(
              heroTag: randomId,
              child: Icon(Icons.add),
              onPressed: () {
                putCategory(Category());
              },
            )
          : null,
    );
  }
}
