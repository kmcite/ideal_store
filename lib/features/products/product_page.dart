import 'dart:io';

import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/utils/extensions.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductsRepository productsRepository = depend();

  Product? _product;
  Product get product => _product ?? widget.product;
  bool get editing => product.editing;

  void onProductUpdated() {
    productsRepository.put(product);
  }

  void onEditingToggled() {
    setState(() => _product?.editing = editing);
  }

  void onProductNameChanged(String name) {
    setState(() => _product?.name = name);
  }

  void onProductModelChanged(String model) {
    setState(() => _product?.model = model);
  }

  void onProductDescriptionChanged(String description) {
    setState(() => _product?.description = description);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('DETAILS'),
        suffixes: [
          FHeaderAction.x(onPress: navigator.back),
        ],
      ),
      child: ListView(
        children: [
          FItemGroup(
            children: [
              FItem(
                title: Text(
                  product.name,
                  style: TextStyle(fontSize: 32),
                ),
                subtitle: editing
                    ? FTextField(
                        initialText: product.name,
                        onChange: onProductNameChanged,
                      )
                    : null,
              ),
              FItem(
                title: Text(
                  product.model,
                  style: TextStyle(fontSize: 32),
                ),
                subtitle: editing
                    ? FTextField(
                        initialText: product.model,
                        onChange: onProductModelChanged,
                      )
                    : null,
              ),
              FItem(
                title: Text(
                  product.description,
                  style: TextStyle(fontSize: 32),
                ),
                subtitle: editing
                    ? FTextField(
                        initialText: product.description,
                        onChange: onProductDescriptionChanged,
                      )
                    : null,
              ),
            ],
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: product.color,
          //     // borderRadius: BorderRadius.circular(settings.borderRadius),
          //   ),
          //   child: product.id.text().pad(),
          // ).pad(),

          // (product.editing
          //         ? DropdownButtonFormField(
          //             initialValue: product.brandType,
          //             items: Brand.values
          //                 .map(
          //                   (e) => DropdownMenuItem(
          //                     value: e,
          //                     child: e.description.text(),
          //                   ),
          //                 )
          //                 .toList(),
          //             onChanged: (brand) {
          //               // productsRM(product.copyWith(brand: brand!));
          //             },
          //           )
          //         : product.brandType.description.text())
          //     .pad(),
          // (product.editing
          //         ? DropdownButtonFormField(
          //             initialValue: product.color,
          //             items: Colors.primaries
          //                 .map(
          //                   (e) => DropdownMenuItem(
          //                     value: e,
          //                     child: e.colorName.text(),
          //                   ),
          //                 )
          //                 .toList(),
          //             onChanged: (materialColor) {
          //               // productsRM(
          //               // product.copyWith(materialColor: materialColor!));
          //             },
          //           )
          //         : product.color.colorName.text())
          //     .pad(),
          (product.editing
                  ? ElevatedButton(
                      onPressed: () async {
                        // final image = await filePicker();
                        // if (image == null) {
                        //   // navigator.scaffold.showSnackBar(
                        //   //   SnackBar(
                        //   //     content: 'Image not selected'
                        //   //         .text()
                        //   //         .pad()
                        //   //         .center(),
                        //   //     duration: 1.seconds,
                        //   //     padding: EdgeInsets.all(8),
                        //   //     behavior: SnackBarBehavior.floating,
                        //   //     margin: EdgeInsets.all(8),
                        //   //   ),
                        //   // );
                        //   return;
                        // }
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
                  ? FSlider(
                      controller: FContinuousSliderController(
                        selection: FSliderSelection(max: 1),
                      ),
                      // min: 0,
                      // max: 99999,
                      // divisions: 99999,
                      // value: product.price.toDouble(),
                      onChange: (price) {
                        // productsRM(product.copyWith(price: price.toInt()));
                      },
                      label: Text(product.price.toStringAsFixed(0)),
                    )
                  : product.price.text())
              .pad(),
          (product.editing
                  ? FSlider(
                      // min: 0,
                      // max: 500,
                      // divisions: 500,
                      // value: product.stock.toDouble(),
                      onChange: (x) {
                        // productsRM(product.copyWith(stock: x.toInt()));
                      },
                      controller: null,
                    )
                  : product.stock.text())
              .pad(),
        ],
      ),
      footer: FButton(
        // heroTag: Random().nextInt(100),
        onPress: onEditingToggled,
        child: Icon(editing ? Icons.store : Icons.edit),
      ).pad(),
    );
  }
}
