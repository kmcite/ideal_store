import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/main.dart';

class UsersRepository extends CrudRepository<User> {
  User? userByEmail(String email) {
    return getAll().where(
      (user) {
        return user.email == email;
      },
    ).firstOrNull;
  }
}
