import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:ideal_store/products/products_bloc.dart';
import 'package:ideal_store/users/add_user_dialog.dart';
import 'package:ideal_store/users/authentication.dart';
import 'package:ideal_store/users/user_tile.dart';
import 'package:manager/manager.dart';

import '../navigator.dart';

class UsersPage extends UI {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'users'.text(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Divider(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: (authenticationBloc.currentUser?.name)
                      .text(textScaleFactor: 2)
                      .pad(),
                ),
                Divider(),
                'products'.text(textScaleFactor: 2).pad(),
                ElevatedButton(
                  onPressed: switch (productsBloc.products) {
                    [] => null,
                    [...] => productsBloc.removeAll,
                  },
                  child: 'delete all products'.text(),
                ).pad(),
                Divider(),
                'customers'.text(textScaleFactor: 2).pad(),
                ElevatedButton(
                  onPressed: switch (usersBloc.users) {
                    [] => null,
                    [...] => usersBloc.removeAll,
                  },
                  child: 'delete all users'.text(),
                ).pad(),
              ],
            ),
            Divider(),
            switch (usersBloc.users.isEmpty) {
              true =>
                'Users are not available'.text(textScaleFactor: 2.3).pad(),
              false => ListView.builder(
                  // separatorBuilder: (context, index) =>
                  //     Divider(thickness: 1, color: Colors.blueGrey, height: 1),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: usersBloc.users.length,
                  itemBuilder: (_, i) {
                    return userRM.inherited(
                      stateOverride: () => usersBloc.users[i],
                      builder: (context) {
                        return UserTile();
                      },
                    );
                  },
                ),
            },
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: randomId,
        child: const Icon(Icons.add_reaction),
        onPressed: () {
          navigator.toDialog(AddUserDialog());
        },
      ).pad(),
    );
  }
}
