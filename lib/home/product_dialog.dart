import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/shared/utils.dart';

class ProductDialog extends StatefulWidget {
  final Product product;

  const ProductDialog({super.key, required this.product});

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  late ProductsRepository productsRepository = depend();

  late final nameController = TextEditingController(text: widget.product.name);
  late final priceController = TextEditingController(
    text: widget.product.price.toString(),
  );
  onSaved() {
    final name = nameController.text;
    final price = int.tryParse(priceController.text) ?? 0;
    productsRepository.put(
      widget.product
        ..name = name
        ..price = price,
    );
    navigator.back();
  }

  onCancelled() {
    navigator.back();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('edit product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'name'),
          ).pad(),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'price'),
            keyboardType: TextInputType.number,
          ).pad(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onCancelled,
          child: Text('Cancel'),
        ),
        FilledButton(
          onPressed: onSaved,
          child: Text('Save'),
        ),
      ],
    );
  }
}
