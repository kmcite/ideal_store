import 'dart:developer';

import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/home/home_page.dart';
import 'package:ideal_store/home/users/authentication.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/shared/utils.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late AuthenticationRepository authenticationRepository = depend();
  late UsersRepository usersRepository = depend();

  final email = TextEditingController(text: 'adn@gmail.com');
  final password = TextEditingController(text: '123456');

  User currentUser = User();

  void onAuthenticated() {
    final user = usersRepository.userByEmail(email.text);
    print('$email $password');
    if (user == null) {
      log('user does not exist');
      return;
    }
    if (user.password != password.text) {
      log('password is incorrect');
      return;
    }

    authenticationRepository.authenticate(user);
    navigator.to(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Authentication'),
        suffixes: [
          FHeaderAction(
            icon: Icon(FIcons.cable),
            onPress: () {
              usersRepository.put(User()
                ..name = 'Test User'
                ..email = 'adn@gmail.com'
                ..password = '123456');
            },
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                "${currentUser.id}".text().pad(),
                "${currentUser.email}".text().pad(),
                "${currentUser.name}".text().pad(),
                "${currentUser.password}".text().pad(),
                "${currentUser.role}".text().pad(),
              ],
            ).pad().pad(),
            FTextField.email(controller: email).pad(),
            FTextField.password(controller: password).pad(),
            FButton(
              onPress: onAuthenticated,
              child: 'login'.text(),
            ).pad(),
            // ...usersBloc.users.map(
            //   (user) => FilledButton(
            //     onPressed: () {
            //       authenticationBloc.authenticate(user.email, user.password);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: user.isAdmin ? Colors.red : Colors.green,
            //     ),
            //     child: user.text(),
            //   ).pad(),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     users(User()..role = Role.admin);
            //   },
            //   child: 'ADMIN'.text(),
            // ),
          ],
        ),
      ),
    );
  }
}
