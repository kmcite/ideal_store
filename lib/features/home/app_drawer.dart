import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/categories_repository.dart';
import 'package:ideal_store/features/categories/edit_category_dialog.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/utils/extensions.dart';

import '../../domain/models/category.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  late CategoriesRepository categoriesRepository = depend();

  bool isCustomer = true;

  Iterable<Category> categories = [];

  void onNavigateToEditDialog() {
    navigator.toDialog(EditCategoryDialog());
    // final response = await navigator.toDialog(EditCategoryDialog());

    // if (response != null) {
    //   categoriesBloc.put(Category()..name = response);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container(
          //   color: settingsBloc.materialColor(),
          //   height: MediaQuery.of(context).viewPadding.top,
          // ),
          DecoratedBox(
            decoration: BoxDecoration(
                // color: settingsBloc.materialColor(),
                ),
            child: Column(
              children: [
                Icon(
                  FIcons.store,
                  size: 64,
                ),
                Text(
                  'Ideal Store',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ).pad(),
          ),
          ...categories.map(
            (category) {
              return FilledButton(
                child: Text(category.name),
                onPressed: () {},
              ).pad();
            },
          ),
          ...categories.map(
            (category) {
              return FilledButton(
                child: Text(category.name),
                onPressed: () {},
              ).pad();
            },
          ).toList(),
          if (categories.isEmpty) Spacer(),
          if (isCustomer)
            FilledButton(
              onPressed: () => onNavigateToEditDialog(),
              child: Icon(Icons.add_circle_outline_sharp),
            ).pad()
        ],
      ),
    );
  }
}
