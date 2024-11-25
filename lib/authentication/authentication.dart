import 'package:ideal_store/main.dart';
import 'package:ideal_store/objectbox.g.dart';

final _users = box<User>(store);
final usersRM = rm(_users);
final users = list(_users, usersRM);

@Entity()
class User {
  int id = 0;
  String name = '';
  String email = '';
  String password = '';
  int roleIndex = 1;
  int cityIndex = 1;

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

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, role: $role}';
  }
}

enum Role {
  admin,
  customer,
}

final currentUserRM = rms<User?>(null);
User get currentUser => currentUserRM.state!;
User? get nullableUser => currentUserRM.state;
bool get isAuthenticated => nullableUser != null;
bool get isAdmin => nullableUser?.role == Role.admin;
final _emailRM = RM.injectTextEditing(text: 'adn@gmail.com');
final _passwordRM = RM.injectTextEditing(text: '1234');

class AuthenticationPage extends UI {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                "${nullableUser?.id}".text().pad(),
                "${nullableUser?.email}".text().pad(),
                "${nullableUser?.name}".text().pad(),
                "${nullableUser?.password}".text().pad(),
                "${nullableUser?.role}".text().pad(),
              ],
            ).pad().card().pad(),
            TextField(
              controller: _emailRM.controller,
              decoration: InputDecoration(labelText: 'Email'),
            ).pad(),
            TextField(
              controller: _passwordRM.controller,
              decoration: InputDecoration(labelText: 'Password'),
            ).pad(),
            FilledButton(
              onPressed: () {
                authenticate(_emailRM.text, _passwordRM.text);
              },
              child: 'Authenticate'.text(),
            ).pad(),
            ...users().map(
              (user) => user.text(),
            ),
            ElevatedButton(
              onPressed: () {
                users(User()..role = Role.admin);
              },
              child: 'ADMIN'.text(),
            ),
          ],
        ),
      ),
    );
  }
}

authenticate(String email, String password) {
  try {
    final user = _users.query(User_.email.equals(email)).build().findFirst();
    print(user);
    if (user != null) {
      if (user.password == password) {
        currentUserRM.state = user;
      } else {
        currentUserRM.state = null;
      }
    } else {
      final newUser = User()
        ..email = email
        ..password = password;
      _users.put(newUser);
      currentUserRM.state = newUser;
    }
  } catch (e) {
    print(e);
  }
}

unAuthenticate() {
  currentUserRM.state = null;
}
