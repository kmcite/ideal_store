import 'dart:async';

import 'package:ideal_store/domain/models/order.dart';
import 'package:ideal_store/domain/models/product.dart';
import 'package:ideal_store/features/users/cities.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User extends Model {
  @Id(assignable: true)
  int id = 0;
  String name = '';
  String email = '';
  String password = '';
  int roleIndex = 1;
  int cityIndex = 1;
  final products = ToMany<Product>();

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

  @Transient()
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
