import 'dart:async';

import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/domain/models/categories.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/home/users/add_user_dialog.dart';
import 'package:ideal_store/home/users/authentication.dart';
import 'package:ideal_store/home/users/user_tile.dart';
import 'package:ideal_store/shared/utils.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late ProductsRepository productsRepository = depend();
  late AuthenticationRepository authenticationRepository = depend();
  late UsersRepository usersRepository = depend();

  late Iterable<Product> products = productsRepository.getAll();
  late Iterable<User> users = usersRepository.getAll();

  late User? currentUser = authenticationRepository.currentUser;

  StreamSubscription<int>? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = productsRepository.watch().listen(
          (_) => setState(
            () {
              products = productsRepository.getAll();
            },
          ),
        );
  }

  void onAllProductsRemoved() => productsRepository.removeAll();
  void onAllUsersRemoved() => usersRepository.removeAll();

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

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
                  child: (currentUser?.name).text(textScaleFactor: 2).pad(),
                ),
                Divider(),
                'products'.text(textScaleFactor: 2).pad(),
                ElevatedButton(
                  onPressed: switch (products.toList()) {
                    [] => null,
                    [...] => onAllProductsRemoved,
                  },
                  child: 'delete all products'.text(),
                ).pad(),
                Divider(),
                'customers'.text(textScaleFactor: 2).pad(),
                ElevatedButton(
                  onPressed: switch (users.toList()) {
                    [] => null,
                    [...] => onAllUsersRemoved,
                  },
                  child: 'delete all users'.text(),
                ).pad(),
              ],
            ),
            Divider(),
            switch (users.isEmpty) {
              true =>
                'Users are not available'.text(textScaleFactor: 2.3).pad(),
              false => ListView.builder(
                  // separatorBuilder: (context, index) =>
                  //     Divider(thickness: 1, color: Colors.blueGrey, height: 1),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (_, i) {
                    final user = users.elementAt(i);
                    return UserTile(user);
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
