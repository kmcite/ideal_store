import 'package:ideal_store/authentication/authentication.dart';

import '../../main.dart';

final customerRM = RM.inject<User>(() => throw UnimplementedError());

final editCustomerRM = rms<int>(0);

class CustomerPage extends UI {
  const CustomerPage({super.key});
  @override
  Widget build(BuildContext context) {
    User customer([User? user]) {
      if (user != null) users(user);
      return users().firstWhere((user) => user.id == editCustomerRM.state);
    }

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("CUSTOMER DETAILS"),
                ),
              ],
            ),
          ),
          'ID'.text().pad(),
          (customer().id).text().pad(),
          'NAME'.text().pad(),
          (customer().name).text(textScaleFactor: 2).pad(),
          'CITY'.text().pad(),
          // (customer().city).text(textScaleFactor: 2).pad(),
          'PRODUCTS'.text().pad(),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: customer()
          //       .products
          //       .map(
          //         (e) => e.text(textScaleFactor: 2).pad(),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
