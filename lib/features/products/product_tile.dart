import 'package:colornames/colornames.dart';
import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/features/products/dialogs/delete_product_dialog.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/utils/extensions.dart';

import 'product_page.dart';

class ProductTilev2 extends StatefulWidget {
  const ProductTilev2({super.key, required this.product});
  final Product product;

  @override
  State<ProductTilev2> createState() => _ProductTilev2State();
}

class _ProductTilev2State extends State<ProductTilev2> {
  late ProductsRepository productsRepository = depend();

  Product get product => widget.product;
  void onDeleteProductDialog() async {
    final result = await navigator.toDialog<bool>(DeleteProductDialog());
    if (result != null && result) {
      productsRepository.remove(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FTile(
      onPress: () => navigator.to(
        ProductPage(product: product),
      ),
      title: product.name.text(),
      subtitle: Column(
        children: [
          product.description.text(),
          product.model.text(),
          product.name.text(),
        ],
      ),
      suffix: FButton.icon(
        style: FButtonStyle.destructive(),
        onPress: onDeleteProductDialog,
        child: Icon(Icons.dangerous),
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.size,
  });

  final Product product;
  final Size size;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late ProductsRepository productsRepository = depend();
  late Product? _product = widget.product;
  Product get product => _product!;

  void onProductRemoved(Product product) {
    productsRepository.remove(product);
  }

  void onProductUpdated(Product product) {
    productsRepository.put(product);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton.filledTonal(
          tooltip: 'edit product',
          onPressed: () {
            // productsRM(product.copyWith(editing: true));
          },
          icon: Icon(Icons.edit_document),
        ).pad(),
        IconButton.filledTonal(
          tooltip: 'name',
          onPressed: null,
          icon: product.name.toUpperCase().text(),
        ).pad(),
        IconButton.filledTonal(
          tooltip: 'brand',
          onPressed: null,
          icon: product.brandType.description.toUpperCase().text(),
        ).pad(),
        IconButton.filled(
          tooltip: 'color',
          onPressed: null,
          icon: product.color.colorName.toUpperCase().text(),
        ).pad(),
        IconButton.filled(
          tooltip: 'model',
          onPressed: null,
          icon: product.model.toUpperCase().text(),
        ).pad(),
        IconButton.filled(
          tooltip: 'price',
          onPressed: null,
          icon: product.price.text(),
        ).pad(),
        IconButton.filled(
          tooltip: 'delete product',
          onPressed: () => onProductRemoved(product),
          icon: Icon(Icons.delete_forever),
        ).pad(),
        IconButton.filled(
          tooltip: 'delete product',
          onPressed: () {
            // ignore: unused_local_variable
            // final order = Order(createdOn: DateTime.now(), customerID: '');
            // ordersRM(
            //   order..addProductToOrder(productID),
            // );
          },
          icon: Icon(Icons.add_task_outlined),
        ).pad(),
        // product.name.text(textScaleFactor: 2).pad(),
        // product.brand.description.text(textScaleFactor: 2).pad(),
        // product.materialColor.colorName
        //     .text(textScaleFactor: 2)
        // .pad(),
        // product.model.text(textScaleFactor: 2).pad(),
        // product.price.floor().text(textScaleFactor: 2).pad(),
        // product.image == ''
        //     ? 'X'.text(textScaleFactor: 4).pad().center()
        //     : Image.memory(
        //         base64Decode(product.image),
        //         fit: BoxFit.fill,
        //       ).clipRadius().pad(),
      ],
    ).pad();
  }

  Widget edit(product) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton.filledTonal(
            tooltip: 'edit product',
            onPressed: () => onProductUpdated(product.copyWith(editing: false)),
            icon: Icon(Icons.done),
          ).pad(),
          TextFormField(
            initialValue: product.name,
            decoration: InputDecoration(
              labelText: 'Product Name',
            ),
            onChanged: (value) {
              onProductUpdated(
                product.copyWith(name: value),
              );
            },
          ).pad(),
          DropdownButtonFormField(
            value: product.brand,
            decoration: InputDecoration(
              labelText: 'Brand',
            ),
            items: Brand.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: e.description.text(),
                  ),
                )
                .toList(),
            onChanged: (value) {
              onProductUpdated(product.copyWith(brand: value!));
            },
          ).pad(),
          DropdownButtonFormField(
            value: product.materialColor,
            items: Colors.primaries
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: e.colorName.text(),
                  ),
                )
                .toList(),
            onChanged: (value) {
              onProductUpdated(product.copyWith(materialColor: value!));
            },
            decoration: InputDecoration(
              labelText: 'Material Color',
            ),
          ).pad(),
          TextFormField(
            initialValue: product.model,
            onChanged: (value) {
              onProductUpdated(product.copyWith(model: value));
            },
            decoration: InputDecoration(labelText: 'Model'),
          ).pad(),
          TextFormField(
            initialValue: product.price.floor().toString(),
            onChanged: (nullablePrice) {
              final price = int.tryParse(nullablePrice);
              if (price == null) return;
              onProductUpdated(product.copyWith(price: price));
            },
            decoration: InputDecoration(labelText: 'Price'),
          ).pad(),
          SizedBox(
            // width: size.width,
            // height: size.width / 1.8,
            child: ElevatedButton(
              onPressed: () async {
                // final filePickerResult = await FilePicker.platform.pickFiles(
                //   withData: true,
                //   allowedExtensions: ['jpg', 'png'],
                //   type: FileType.custom,
                // );
                // if (filePickerResult == null) {
                //   return;
                // }
                // final image = filePickerResult.files.first;
                // if (image.bytes == null) {
                //   return;
                // }
                // productsBloc.put(
                //   product.copyWith(image: image.bytes!),
                // );
              },
              child: product.image == ''
                  ? 'Pick Image'.text()
                  : Image.memory(
                      (product.image),
                      fit: BoxFit.cover,
                    ),
            ).pad(),
          ),
          Stack(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(settings.borderRadius),
                child: LinearProgressIndicator(
                  minHeight: 40,
                  value: product.stock / 500,
                ),
              ),
              Center(
                child: "${product.stock}/500".text(
                  textScaleFactor: 2,
                  // style: TextStyle(
                  //   color: settings.materialColor.shade800,
                  // ),
                ),
              )
            ],
          ).pad(),
          Slider(
            value: product.stock.toDouble(),
            onChanged: (stock) {
              onProductUpdated(
                product.copyWith(stock: stock.toInt()),
              );
            },
            min: 0,
            max: 500,
          )
        ],
      ).pad();
}
