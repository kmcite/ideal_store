import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/home/users/authentication.dart';
import 'package:ideal_store/shared/utils.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late AuthenticationRepository authenticationRepository = depend();
  late User? user = authenticationRepository.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          'ID'.text().pad(),
          (user?.id).text().pad(),
          'NAME'.text().pad(),
          (user?.name).text(textScaleFactor: 2).pad(),
          'CITY'.text().pad(),
          // (customer().city).text(textScaleFactor: 2).pad(),
          'PRODUCTS'.text().pad(),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: customer()
          //       .products
          //       .map(
          //         (e) => e.text(textScaleFactor: 2).pad(),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
