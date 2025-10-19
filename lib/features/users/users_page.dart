import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/features/users/add_user_dialog.dart';
import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/features/users/user_tile.dart';
import 'package:ideal_store/utils/extensions.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late ProductsRepository productsRepository = depend();
  late AuthenticationRepository authenticationRepository = depend();
  late UsersRepository usersRepository = depend();

  /// STATE
  Iterable<Product> get products => productsRepository.getAll();
  Iterable<User> get users => usersRepository.getAll();
  User? get currentUser => authenticationRepository.currentUser;

  void onAllProductsRemoved() => productsRepository.removeAll();
  void onAllUsersRemoved() => usersRepository.removeAll();

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Users'),
        suffixes: [
          FHeaderAction(
            icon: const Icon(Icons.add_reaction),
            onPress: () => navigator.toDialog(AddUserDialog()),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          spacing: 8,
          children: [
            Column(
              spacing: 8,
              children: [
                'products'.text(textScaleFactor: 2),
                FButton(
                  onPress: switch (products.toList()) {
                    [] => null,
                    [...] => onAllProductsRemoved,
                  },
                  child: 'delete all products'.text(),
                ),
                'customers'.text(textScaleFactor: 2),
                FButton(
                  onPress: switch (users.toList()) {
                    [] => null,
                    [...] => onAllUsersRemoved,
                  },
                  child: 'delete all users'.text(),
                ),
              ],
            ),
            Expanded(
              child: switch (users.isEmpty) {
                true =>
                  'Users are not available'.text(textScaleFactor: 2.3).pad(),
                false => ListView(
                    children: [
                      for (final user in users) UserTile(user),
                    ],
                    physics: const BouncingScrollPhysics(),
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
