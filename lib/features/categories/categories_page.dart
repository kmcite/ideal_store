import 'dart:math';

import 'package:ideal_store/domain/api/categories_repository.dart';
import 'package:ideal_store/domain/models/category.dart';
import 'package:ideal_store/utils/extensions.dart';

import '../../main.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
              heroTag: Random().nextInt(100),
              child: Icon(Icons.add),
              onPressed: () {
                putCategory(Category());
              },
            )
          : null,
    );
  }
}
