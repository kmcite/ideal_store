import 'package:ideal_store/domain/models/order.dart';
import 'package:ideal_store/main.dart';
import 'package:objectbox/objectbox.dart';

enum Brand {
  urideal('URideal'),
  chinese('Chinese'),
  pakistani('Pakistani');

  const Brand(this.description);
  final String description;
}

@Entity()
class Product extends Model {
  @Id(assignable: true)
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
    brandIndex = value.index;
  }

  @Transient()
  MaterialColor get color => Colors.primaries[colorIndex];
  set color(MaterialColor value) {
    colorIndex = Colors.primaries.indexOf(value);
  }
}
