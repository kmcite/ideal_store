import 'package:ideal_store/objectbox.g.dart';
import 'package:ideal_store/products/product.dart';

import '../users/authentication.dart';

enum OrderStatus {
  ordered,
  delivering,
  complete;
}

@Entity()
class Order {
  @Id(assignable: true)
  int id = 0;
  bool editing = true;

  int statusIndex = 0;
  @Transient()
  OrderStatus get orderStatus => OrderStatus.values[statusIndex];
  @Transient()
  set orderStatus(OrderStatus status) =>
      statusIndex = OrderStatus.values.indexOf(status);

  DateTime createdOn = DateTime.now();

  final customer = ToOne<User>();
  final products = ToMany<Product>();
}
