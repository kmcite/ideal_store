import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/features/home/home_page.dart';
import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/utils/extensions.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late AuthenticationRepository authenticationRepository = depend();
  late UsersRepository usersRepository = depend();

  /// CONTROLLERS
  final email = TextEditingController(text: 'adn@gmail.com');
  final password = TextEditingController(text: '123456');

  /// STATE
  User currentUser = User();

  void onAuthenticated() {
    final user = usersRepository.userByEmail(email.text);

    if (user == null) {
      showToast('user does not exist');
      return;
    }
    if (user.password != password.text) {
      showToast('password is incorrect');
      return;
    }
    authenticationRepository.authenticate(user);
    navigator.toReplacement(HomePage());
  }

  void showToast(String message) {
    showFToast(
      context: context,
      title: Text(message),
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FToaster(
      child: FScaffold(
        header: FHeader(
          title: Text('Authentication'),
          suffixes: [
            FHeaderAction(
              icon: Icon(FIcons.cable),
              onPress: () {
                usersRepository.put(
                  User()
                    ..name = 'Test User'
                    ..email = 'adn@gmail.com'
                    ..password = '123456',
                );
              },
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FTextField.email(controller: email).pad(),
              FTextField.password(controller: password).pad(),
              FButton(
                onPress: onAuthenticated,
                child: 'Login'.text(),
              ).pad(),
            ],
          ),
        ),
      ),
    );
  }
}
