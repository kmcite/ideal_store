import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/orders_repository.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/order.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/utils/extensions.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrdersRepository ordersRepository = depend();

  /// STATE
  Iterable<Order> get orders => ordersRepository.getAll();

  /// UI
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      header: FHeader(
        title: Text('Orders'),
        // suffixes: [
        //   FHeaderAction(
        //     onPress: () {},
        //     icon: Icon(Icons.dashboard),
        //   ),
        //   FHeaderAction(
        //     onPress: () {},
        //     icon: Icon(Icons.account_box_sharp),
        //   ),
        // ],
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) => OrderTile(
            order: orders.elementAt(index),
          ),
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  final Order order;
  const OrderTile({super.key, required this.order});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  late ProductsRepository productsRepository = depend();
  Iterable<Product> get products => productsRepository.getAll();
  Order get order => widget.order;

  void onOrderStatusChanged(OrderStatus? orderStatus) {}
  void onProductChanged(Product? product) {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: order.text(),
      subtitle: Column(
        children: [
          DropdownButtonFormField(
            value: order.orderStatus,
            items: OrderStatus.values
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: status.name.toUpperCase().text(),
                  ),
                )
                .toList(),
            onChanged: onOrderStatusChanged,
          ),
          SizedBox(
            height: 400,
            child: GridView.count(
              crossAxisCount: 2,
              children: order.products
                  .map(
                    (eachProductID) => products.where(
                      (element) {
                        return element.id == eachProductID.id;
                      },
                    ),
                  )
                  .map(
                    (eachProduct) => eachProduct.text(),
                  )
                  .toList(),
            ),
          ),
          DropdownButtonFormField(
            items: products
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: e.name.text(),
                  ),
                )
                .toList(),
            onChanged: onProductChanged,
          ),
        ],
      ),
    );
  }
}
