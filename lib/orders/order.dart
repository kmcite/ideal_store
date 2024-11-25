import 'package:ideal_store/authentication/authentication.dart';
import 'package:ideal_store/main.dart';

enum OrderStatus {
  ordered,
  delivering,
  complete;
}

@Entity()
class Order {
  @ID
  int id = 0;
  bool editing = true;

  int statusIndex = 0;
  @Transient()
  OrderStatus get orderStatus => OrderStatus.values[statusIndex];
  set orderStatus(OrderStatus status) =>
      statusIndex = OrderStatus.values.indexOf(status);

  DateTime createdOn = DateTime.now();

  /// RELATIONSHIPS
  final customer = ToOne<User>();
  final products = ToMany<Product>();

  // void addProductToOrder(String productID) {
  //   ordersRM(
  //     copyWith(
  //       products: List.of(products)..add(productID),
  //     ),
  //   );
  // }

  // void deleteProductFromOrder(String productID) {
  //   ordersRM(
  //     copyWith(
  //       products: List.of(products)..remove(productID),
  //     ),
  //   );
  // }
}

final _orders = box<Order>(store);

final ordersRM = rm(_orders);

final orders = list(_orders, ordersRM);

void addOrder(Order value) => orders(value);
void removeOrder(int id) => _orders.remove(id);
void removeAllOrders() => _orders.removeAll();
