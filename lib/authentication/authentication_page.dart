import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:manager/manager.dart';

class AuthenticationPage extends UI {
  const AuthenticationPage({super.key});

  static final emailRM = RM.injectTextEditing(text: 'adn@gmail.com');
  static final passwordRM = RM.injectTextEditing(text: '1234');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Column(
            //   children: [
            //     "${authenticationBloc.currentUser?.id}".text().pad(),
            //     "${authenticationBloc.currentUser?.email}".text().pad(),
            //     "${authenticationBloc.currentUser?.name}".text().pad(),
            //     "${authenticationBloc.currentUser?.password}".text().pad(),
            //     "${authenticationBloc.currentUser?.role}".text().pad(),
            //   ],
            // ).pad().card().pad(),
            TextField(
              controller: emailRM.controller,
              decoration: InputDecoration(labelText: 'Email'),
            ).pad(),
            TextField(
              controller: passwordRM.controller,
              decoration: InputDecoration(labelText: 'Password'),
            ).pad(),
            FilledButton(
              onPressed: () {
                authenticationBloc.authenticate(emailRM.text, passwordRM.text);
              },
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
