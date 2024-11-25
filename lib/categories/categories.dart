import 'package:ideal_store/authentication/authentication.dart';
import 'package:ideal_store/main.dart';

@Entity()
class Category {
  @ID
  int id = 0;
  String name = "";
}

final categories = list(_categories, categoriesRM);
final categoriesRM = rm(_categories);
final _categories = box<Category>(store);

final categoryRemover = _categories.remove;

class CategoriesUI extends UI {
  const CategoriesUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CATEGORIES'),
      ),
      body: ListView.builder(
        itemCount: categories().length,
        itemBuilder: (context, index) {
          final category = categories()[index];
          return ListTile(
            title: isAdmin
                ? TextFormField(
                    initialValue: category.name,
                    onChanged: (value) {
                      categories(category..name = value);
                    },
                  )
                : FilledButton(
                    onPressed: () {},
                    child: category.name.text(),
                  ),
            trailing: isAdmin
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      categoryRemover(category.id);
                    },
                  )
                : null,
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                categories(Category());
              },
            )
          : null,
    );
  }
}
