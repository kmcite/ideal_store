import 'package:ideal_store/orders/order.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'orders_repository.dart';

class OrdersBloc {
  OrdersRepository get _ordersRepository => ordersRepository;

  late final ordersRM = RM.inject(() => _ordersRepository.getAll());

  List<Order> get orders => ordersRM.state;

  void put(Order order) {
    _ordersRepository.put(order);
    ordersRM.stateAsync = _ordersRepository.getAllAsync();
  }

  void remove(int id) {
    _ordersRepository.remove(id);
    ordersRM.stateAsync = _ordersRepository.getAllAsync();
  }

  void removeAll() {
    _ordersRepository.removeAll();
    ordersRM.stateAsync = _ordersRepository.getAllAsync();
  }
}

final ordersBloc = OrdersBloc();
