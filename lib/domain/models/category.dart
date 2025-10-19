import 'package:ideal_store/domain/models/order.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Category extends Model {
  @Id(assignable: true)
  int id = 0;
  String name;
  Category({
    this.id = 0,
    this.name = '',
  });
}
