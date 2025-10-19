import 'package:forui/forui.dart';

import '../../../main.dart';

class DeleteProductDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text("Delete Product"),
      body: Text("Are you sure you want to delete this product?"),
      direction: Axis.horizontal,
      actions: [
        FButton(
          child: Text("Confirm"),
          style: FButtonStyle.destructive(),
          onPress: () {
            navigator.back(true);
          },
        ),
        FButton(
          child: Text("Cancel"),
          onPress: () {
            navigator.back(false);
          },
        ),
      ],
    );
  }
}
