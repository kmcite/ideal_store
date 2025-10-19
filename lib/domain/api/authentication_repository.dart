import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/main.dart';

class AuthenticationRepository extends Repository<User> {
  User? currentUser;
  bool get admin => true;
  bool get authenticated => currentUser != null;

  void authenticate(User user) {
    currentUser = user;
    notify();
  }

  void unauthenticate() {
    currentUser = null;
    notify();
  }
}
