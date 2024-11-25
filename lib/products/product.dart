import '../main.dart';

enum Brand {
  urideal('URideal'),
  chinese('Chinese'),
  pakistani('Pakistani');

  const Brand(this.description);
  final String description;
}

final _products = box<Product>(store);
final productsRM = rm(_products);
final products = list(_products, productsRM);

void removeProduct(int id) => _products.remove(id);

@Entity()
class Product {
  @ID
  int id = 0;
  String name = '';
  String description = '';
  String model = '';
  String? path;
  bool editing = false;
  int brandIndex = 0;
  int colorIndex = 0;
  int stock = 0;
  int price = 0;

  @Transient()
  Brand get brandType => Brand.values[brandIndex];
  set brandType(Brand value) {
    products(this..brandIndex = value.index);
  }

  @Transient()
  MaterialColor get color => Colors.primaries[colorIndex];
  set color(MaterialColor value) {
    products(this..colorIndex = Colors.primaries.indexOf(value));
  }
}
