import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:ideal_store/categories/categories_bloc.dart';
import 'package:manager/manager.dart';

@Entity()
class Category {
  @Id(assignable: true)
  int id = 0;
  String name = "";
}

class CategoriesUI extends UI {
  const CategoriesUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CATEGORIES'),
      ),
      body: ListView.builder(
        itemCount: categoriesBloc.categories.length,
        itemBuilder: (context, index) {
          final category = categoriesBloc.categories[index];
          return ListTile(
            title: authenticationBloc.isAdmin
                ? TextFormField(
                    initialValue: category.name,
                    onChanged: (value) {
                      categoriesBloc.put(category..name = value);
                    },
                  )
                : FilledButton(
                    onPressed: () {},
                    child: category.name.text(),
                  ),
            trailing: authenticationBloc.isAdmin
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      categoriesBloc.remove(category.id);
                    },
                  )
                : null,
          );
        },
      ),
      floatingActionButton: authenticationBloc.isAdmin
          ? FloatingActionButton(
              heroTag: randomId,
              child: Icon(Icons.add),
              onPressed: () {
                categoriesBloc.put(Category());
              },
            )
          : null,
    );
  }
}
