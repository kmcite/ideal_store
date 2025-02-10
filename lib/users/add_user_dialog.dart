import 'package:ideal_store/users/authentication.dart';
import 'package:manager/manager.dart';

/// LOCAL STATES

final _userToAddRM = RM.inject(
  () => User(),
);

User get userToAdd => _userToAddRM.state;
set userToAdd(User user) {
  _userToAddRM
    ..state = user
    ..notify();
}

class AddUserDialog extends UI {
  const AddUserDialog({super.key});

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
              usersBloc.put(userToAdd);
              userToAdd = User();
            },
            child: 'SAVE'.text(),
          ).pad(),
        ],
      ),
    );
  }
}
