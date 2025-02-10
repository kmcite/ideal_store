import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:ideal_store/categories/categories_bloc.dart';
import 'package:ideal_store/navigator.dart';
import 'package:ideal_store/settings/settings_controller.dart';
import 'package:manager/manager.dart' hide Category;
import 'package:shadcn_ui/shadcn_ui.dart';

import '../categories/categories.dart';

class AppDrawer extends UI {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: settingsBloc.materialColor(),
            height: MediaQuery.of(context).viewPadding.top,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: settingsBloc.materialColor(),
            ),
            child: Column(
              children: [
                Icon(
                  LucideIcons.store,
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
          ...categoriesBloc.categories.map(
            (category) {
              return FilledButton(
                child: Text(category.name),
                onPressed: () {},
              ).pad();
            },
          ).toList(),
          if (categoriesBloc.categories.isEmpty) Spacer(),
          if (authenticationBloc.isCustomer)
            FilledButton(
              onPressed: () async {
                final response =
                    await navigator.toDialog<String>(EditCategoryDialog());
                if (response != null) {
                  categoriesBloc.put(Category()..name = response);
                }
              },
              child: Icon(Icons.add_circle_outline_sharp),
            ).pad()
        ],
      ),
    );
  }
}

class EditCategoryDialog extends UI {
  const EditCategoryDialog({super.key});

  static final nameRM = RM.injectTextEditing();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add new category'),
      content: TextFormField(
        controller: nameRM.controller,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            navigator.back();
          },
          child: Icon(Icons.cancel_outlined),
        ),
        ElevatedButton(
          onPressed: () {
            navigator.back(nameRM.text);
          },
          child: Icon(LucideIcons.save),
        ),
      ],
    );
  }
}
