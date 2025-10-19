import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/features/users/profile/city_update.dart';
import 'package:ideal_store/features/users/profile/name_update.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/utils/extensions.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late AuthenticationRepository authenticationRepository = depend();
  late UsersRepository usersRepository = depend();
  User? get user {
    final id = authenticationRepository.currentUser?.id;
    if (id == null) return null;
    return usersRepository.get(id);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('User Profile'),
      ),
      child: user == null
          ? Center(
              child: 'No user'.text(textScaleFactor: 2).pad(),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                'ID'.text().pad(),
                (user?.id).text().pad(),
                'NAME'.text().pad(),
                (user?.name).text(textScaleFactor: 2).pad(),
                'CITY'.text().pad(),
                (user?.city).text(textScaleFactor: 2).pad(),
                'PRODUCTS'.text().pad(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: user!.products.map(
                    (e) {
                      return e.text(textScaleFactor: 2).pad();
                    },
                  ).toList(),
                ),
                FItemGroup(
                  children: [
                    FItem(
                      title: Text(
                        'Update Name',
                      ),
                      onPress: () {
                        navigator.toDialog(NameUpdateDialog());
                      },
                    ),
                    FItem(
                      title: Text(
                        'Update City',
                      ),
                      onPress: () {
                        navigator.toDialog(CityUpdateDialog());
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
