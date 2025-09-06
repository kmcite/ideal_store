import 'package:forui/forui.dart';
import 'package:ideal_store/main.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({super.key});

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final nameRM = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add new category'),
      content: TextFormField(
        controller: nameRM,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // navigator.back();
            navigator.back();
          },
          child: Icon(Icons.cancel_outlined),
        ),
        ElevatedButton(
          onPressed: () {
            navigator.back();
            nameRM.text;
          },
          child: Icon(FIcons.save),
        ),
      ],
    );
  }
}
