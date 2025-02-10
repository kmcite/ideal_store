import 'package:ideal_store/users/authentication.dart';
import 'package:manager/manager.dart';

import 'user_tile.dart';

class UserPage extends UI {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    User user([User? user]) {
      if (user != null) {
        userRM
          ..state = user
          ..notify();
      }
      return userRM.of(context);
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
          (user().id).text().pad(),
          'NAME'.text().pad(),
          (user().name).text(textScaleFactor: 2).pad(),
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
