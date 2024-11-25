import 'dart:io';

import '../../main.dart';
import 'file_picker.dart';

class ProductPage extends UI {
  final int productID;
  const ProductPage({super.key, required this.productID});
  @override
  Widget build(BuildContext context) {
    final product = products().firstWhere((p) => p.id == productID);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Container(
                  decoration: BoxDecoration(
                    color: product.color,
                    // borderRadius: BorderRadius.circular(settings.borderRadius),
                  ),
                  child: const Text("PRODUCT DETAILS").pad(),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: product.color,
              // borderRadius: BorderRadius.circular(settings.borderRadius),
            ),
            child: product.id.text().center().pad(),
          ).pad(),
          (product.editing
                  ? TextFormField(
                      initialValue: product.name,
                      onChanged: (name) {
                        // productsRM(product.copyWith(name: name));
                      },
                    )
                  : product.name.text(textScaleFactor: 3))
              .pad(),
          (product.editing
                  ? TextFormField(
                      initialValue: product.model,
                      onChanged: (model) {
                        // productsRM(
                        // product.copyWith(model: model),
                        // );
                      },
                    )
                  : product.model.text(textScaleFactor: 2))
              .pad(),
          (product.editing
                  ? DropdownButtonFormField(
                      // value: product.brand,
                      items: Brand.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: e.description.text(),
                            ),
                          )
                          .toList(),
                      onChanged: (brand) {
                        // productsRM(product.copyWith(brand: brand!));
                      },
                    )
                  : product.brandType.description.text())
              .pad(),
          (product.editing
                  ? DropdownButtonFormField(
                      value: product.color,
                      items: Colors.primaries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: e.colorName.text(),
                            ),
                          )
                          .toList(),
                      onChanged: (materialColor) {
                        // productsRM(
                        // product.copyWith(materialColor: materialColor!));
                      },
                    )
                  : product.color.colorName.text())
              .pad(),
          (product.editing
                  ? ElevatedButton(
                      onPressed: () async {
                        final image = await filePicker();
                        if (image == null) {
                          // navigator.scaffold.showSnackBar(
                          //   SnackBar(
                          //     content: 'Image not selected'
                          //         .text()
                          //         .pad()
                          //         .center(),
                          //     duration: 1.seconds,
                          //     padding: EdgeInsets.all(8),
                          //     behavior: SnackBarBehavior.floating,
                          //     margin: EdgeInsets.all(8),
                          //   ),
                          // );
                          return;
                        }
                        // productsRM(product.copyWith(image: image));
                      },
                      child: 'Pick Image'.text(),
                    )
                  : product.path == null
                      ? 'Image not found.'.text()
                      : Card(
                          child: Image.memory(
                            File(product.path!).readAsBytesSync(),
                          ).pad(),
                        ))
              .pad(),
          (product.editing
                  ? Slider(
                      min: 0,
                      max: 99999,
                      divisions: 99999,
                      value: product.price.toDouble(),
                      onChanged: (price) {
                        // productsRM(product.copyWith(price: price.toInt()));
                      },
                      label: product.price.toStringAsFixed(0),
                    )
                  : product.price.text())
              .pad(),
          (product.editing
                  ? Slider(
                      min: 0,
                      max: 500,
                      divisions: 500,
                      value: product.stock.toDouble(),
                      onChanged: (x) {
                        // productsRM(product.copyWith(stock: x.toInt()));
                      },
                    )
                  : product.stock.text())
              .pad(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // productsRM(product.copyWith(editing: !product.editing));
        },
        child: Icon(
          product.editing ? Icons.store : Icons.edit,
        ),
      ),
    );
  }
}
