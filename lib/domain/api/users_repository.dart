import 'dart:async';

import 'package:ideal_store/home/users/authentication.dart';
import 'package:ideal_store/domain/api/repository.dart';

class UsersRepository extends CrudRepository<User> {
  User? userByEmail(String email) {
    return getAll().where(
      (user) {
        return user.email == email;
      },
    ).firstOrNull;
  }
}

class AuthenticationRepository extends Repository<User> {
  int count = 0;
  final controller = StreamController<int>.broadcast();
  Stream<int> watch() => controller.stream;
  User? currentUser;
  bool get admin => true;
  bool get authenticated => currentUser != null;

  void authenticate(User user) {
    currentUser = user;
    notify();
  }

  void notify() => controller.add(count + 1);

  void unauthenticate() {
    currentUser = null;
    notify();
  }
}
