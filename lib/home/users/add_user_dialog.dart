import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/home/users/authentication.dart';
import 'package:ideal_store/shared/utils.dart';

/// LOCAL STATES

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  late UsersRepository usersRepository;

  User userToAdd = User();

  void onUserSaved(User user) {
    usersRepository.put(user);
    userToAdd = User();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'NEW USER'.text(textScaleFactor: 3).pad(),
          TextFormField(
            initialValue: userToAdd.name,
            decoration: InputDecoration(
              labelText: 'USER NAME',
            ),
            onChanged: (value) => userToAdd = userToAdd..name = value,
          ).pad(),
          TextFormField(
            initialValue: userToAdd.password,
            onChanged: (value) => userToAdd = userToAdd..password = value,
            decoration: InputDecoration(
              labelText: 'PASSWORD',
            ),
            obscureText: true,
          ).pad(),
          TextFormField(
            initialValue: userToAdd.email,
            onChanged: (value) => userToAdd = userToAdd..email = value,
            decoration: InputDecoration(
              labelText: 'EMAIL',
            ),
          ).pad(),
          Row(
            children: Role.values.map(
              (role) {
                return Expanded(
                  child: FilledButton(
                    onPressed: userToAdd.role == role
                        ? null
                        : () {
                            userToAdd = userToAdd..role = role;
                          },
                    child: role.name.toUpperCase().text(),
                  ).pad(),
                );
              },
            ).toList(),
          ),
          FilledButton(
            onPressed: () {
              onUserSaved(userToAdd);
            },
            child: 'SAVE'.text(),
          ).pad(),
        ],
      ),
    );
  }
}
