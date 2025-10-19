import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/features/users/cities.dart';
import 'package:ideal_store/main.dart';

class CityUpdateDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CityUpdateDialogState();
  }
}

class _CityUpdateDialogState extends State<CityUpdateDialog> {
  late UsersRepository usersRepository = depend();
  late AuthenticationRepository authenticationRepository = depend();
  User? get user {
    final id = authenticationRepository.currentUser?.id;
    if (id == null) return null;
    return usersRepository.get(id);
  }

  late City city = user!.city;

  void onCityChanged(City value) {
    setState(() => city = value);
  }

  void onSaved() {
    if (user != null) usersRepository.put(user!..city = city);
    navigator.back();
  }

  void onCancelled() => navigator.back();

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('Update City'),
      body: SizedBox(
        height: 500,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: City.values.length,
          itemBuilder: (context, index) {
            final city = City.values[index];
            return FTile(
              suffix: city == this.city ? Icon(Icons.check) : null,
              title: Text(city.cityName),
              onPress: () => onCityChanged(city),
            );
          },
        ),
      ),
      direction: Axis.horizontal,
      actions: [
        FButton(
          child: Text('Cancel'),
          onPress: onCancelled,
        ),
        FButton(
          child: Text('Save'),
          onPress: onSaved,
        ),
      ],
    );
  }
}
