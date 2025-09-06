import 'package:ideal_store/domain/api/orders_repository.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/models/order.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/shared/utils.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrdersRepository ordersRepository = depend();

  /// STATE
  late Iterable<Order> orders = ordersRepository.getAll();
  @override
  void initState() {
    super.initState();
    ordersRepository.watch().listen(listener);
  }

  /// UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Orders'),
        actions: [
          IconButton(
            tooltip: 'Back to Dashboard',
            onPressed: () {
              navigator.back();
            },
            icon: Icon(Icons.dashboard),
          ).pad(),
          IconButton(
            tooltip: 'place orders for customer',
            onPressed: () {},
            icon: Icon(Icons.account_box_sharp),
          ).pad(),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders.elementAt(index);
            return ListTile(
              title: Text(order.customer.target!.name),
            );
          },
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  final Order order;
  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  late ProductsRepository productsRepository = depend();
  late Iterable<Product> products = productsRepository.getAll();
  late Order order;

  @override
  void initState() {
    productsRepository.watch().listen(
          (_products) => setState(
            () => products = productsRepository.getAll(),
          ),
        );
    order = widget.order;
    super.initState();
  }

  void onOrderStatusChanged(OrderStatus? orderStatus) {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: order.text(),
      subtitle: Column(
        children: [
          DropdownButtonFormField(
            initialValue: order.orderStatus,
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
            onChanged: (onChanged) {
              // ordersRM(
              //   order..addProductToOrder(onChanged!.id),
              // );
            },
          ),
        ],
      ),
    );
  }
}
