import 'package:ideal_store/users/users_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../users/authentication.dart';

class AuthenticationBloc {
  UsersRepository get _usersRepository => usersRepository;

  final authenticationRM = RM.inject<int?>(() => null);
  int? get state => authenticationRM.state;
  setAuthentication([int? value = null]) => authenticationRM.state = value;

  User? get currentUser {
    if (state != null) return _usersRepository.get(state!);
    return null;
  }

  User get signedInUser => currentUser!;

  bool get isAuthenticated => currentUser != null;
  bool get isAdmin => currentUser?.role == Role.admin;
  bool get isCustomer => currentUser?.role == Role.customer;

  authenticate(String email, String password) {
    try {
      /// really we need bloc or we need repo access? TODO
      final user = usersBloc.userByEmail(email);
      print(user);
      if (user != null) {
        if (user.password == password) {
          setAuthentication(user.id);
        } else {
          setAuthentication();
        }
      } else {
        final newUser = User()
          ..email = email
          ..password = password;
        usersBloc.put(newUser);
        setAuthentication(newUser.id);
      }
    } catch (e) {
      print(e);
    }
  }

  unAuthenticate() {
    setAuthentication();
  }
}

final AuthenticationBloc authenticationBloc = AuthenticationBloc();
