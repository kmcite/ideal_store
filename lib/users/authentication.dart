import 'dart:async';

import 'package:ideal_store/objectbox.g.dart';
import 'package:ideal_store/shared/cities.dart';
import 'package:ideal_store/users/users_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final usersBloc = UsersBloc();

class UsersBloc {
  final usersRM = RM.inject(() => usersRepository.getAll());

  List<User> get users => usersRM.state;

  void put(User user) {
    usersRepository.put(user);
    usersRM.stateAsync = usersRepository.getAllAsync();
  }

  void remove(int id) {
    usersRepository.remove(id);
    usersRM.stateAsync = usersRepository.getAllAsync();
  }

  void removeAll() {
    usersRepository.removeAll();
    usersRM.stateAsync = usersRepository.getAllAsync();
  }

  /// Dangerous API
  /// may cause un-authorize data access
  User? userByEmail(String email) =>
      usersRepository.query(User_.email.equals(email)).build().findFirst();
}

@Entity()
class User {
  @Id(assignable: true)
  int id = 0;
  String name = '';
  String email = '';
  String password = '';
  int roleIndex = 1;
  int cityIndex = 1;

  static FutureOr<User?> fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      final user = User();
      user.id = json['id'] as int;
      user.name = json['name'] as String;
      user.email = json['email'] as String;
      user.password = json['password'] as String;
      user.roleIndex = json['roleIndex'] as int;
      user.cityIndex = json['cityIndex'] as int;
      return user;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'roleIndex': roleIndex,
      'cityIndex': cityIndex,
    };
  }

  @Transient()
  City get city => City.values[cityIndex];
  set city(City value) {
    cityIndex = City.values.indexOf(value);
  }

  @Transient()
  Role get role => Role.values[roleIndex];
  set role(Role value) {
    roleIndex = Role.values.indexOf(value);
  }

  @Transient()
  bool get isAdmin => role == Role.admin;
  @Transient()
  bool get isCustomer => role == Role.customer;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, role: $role}';
  }
}

enum Role {
  admin,
  customer,
}
