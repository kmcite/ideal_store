import 'package:ideal_store/main.dart';
import 'package:ideal_store/orders/order.dart';

class OrdersRepository {
  final _orders = store.box<Order>();
  late final getAll = _orders.getAll;
  late final getAllAsync = _orders.getAllAsync;
  late final get = _orders.get;
  late final put = _orders.put;
  late final remove = _orders.remove;
  late final removeAll = _orders.removeAll;
}

final ordersRepository = OrdersRepository();
// OrdersRepository get _ordersRepository => ordersRepository;
