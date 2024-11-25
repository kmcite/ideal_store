import 'package:ideal_store/main.dart';

import 'order.dart';

class OrdersPage extends UI {
  static const path = '/orders';

  const OrdersPage({super.key});
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
              // navigator();
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
          itemCount: orders().length,
          itemBuilder: (context, index) {
            return orderRM.inherited(
              stateOverride: () => orders()[index],
              builder: (context) {
                return ListTile();
              },
            );
          },
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

final orderRM = RM.inject<Order>(
  () => throw UnimplementedError(),
);

class OrderTile extends UI {
  const OrderTile({super.key});
  @override
  Widget build(BuildContext context) {
    Order order([Order? value]) {
      if (value != null) orderRM.state = value;
      return orderRM.of(context);
    }

    return ListTile(
      title: order.text(),
      subtitle: Column(
        children: [
          DropdownButtonFormField(
            value: order().orderStatus,
            items: OrderStatus.values
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: status.name.toUpperCase().text(),
                  ),
                )
                .toList(),
            onChanged: (orderStatus) {
              // ordersRM(
              //   order.copyWith(orderStatus: orderStatus!),
              // );
            },
          ),
          SizedBox(
            height: 400,
            child: GridView.count(
              crossAxisCount: 2,
              children: order()
                  .products
                  .map(
                    (eachProductID) => products().where(
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
            items: products()
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
