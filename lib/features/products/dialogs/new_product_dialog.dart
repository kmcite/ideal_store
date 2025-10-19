import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/main.dart';

class NewProductDialog extends StatefulWidget {
  const NewProductDialog({super.key});

  @override
  State<NewProductDialog> createState() => _NewProductDialogState();
}

class _NewProductDialogState extends State<NewProductDialog> {
  late ProductsRepository productsRepository = depend();

  late Product product = Product();

  late final name = TextEditingController(text: product.name);
  late final description = TextEditingController(text: product.description);
  late final model = TextEditingController(text: product.model);
  late final brand = FSelectTileGroupController<Brand>.radio(product.brandType);

  late final price = TextEditingController(
    text: '',
  );
  onSaved() {
    productsRepository.put(
      product
        ..name = name.text
        ..description = description.text
        ..model = model.text
        ..brandType = brand.value.first
        ..price = int.tryParse(price.text) ?? 0,
    );
    navigator.back();
  }

  onCancelled() {
    navigator.back();
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('Add New Product'),
      body: Column(
        spacing: 8,
        children: [
          FTextField(
            controller: name,
            label: Text('Name'),
          ),
          FTextField(
            controller: description,
            label: Text('Description'),
          ),
          FTextField(
            controller: model,
            label: Text('Model'),
          ),
          FTextField(
            controller: price,
            label: Text('Price'),
          ),
          FSelectTileGroup.builder(
            label: Text('Brand'),
            count: Brand.values.length,
            selectController: brand,
            tileBuilder: (context, i) {
              final value = Brand.values[i];
              return FSelectTile(
                value: value,
                title: Text(value.name),
              );
            },
          ),
        ],
      ),
      actions: [
        FButton(
          onPress: onCancelled,
          child: Text('Cancel'),
        ),
        FButton(
          onPress: onSaved,
          child: Text('Save'),
        ),
      ],
      direction: Axis.horizontal,
    );
  }
}
