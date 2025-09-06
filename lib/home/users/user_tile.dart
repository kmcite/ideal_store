import 'package:ideal_store/main.dart';
import 'package:ideal_store/home/users/authentication.dart';
import 'package:ideal_store/shared/utils.dart';

class UserTile extends StatefulWidget {
  final User user;
  const UserTile(this.user, {super.key});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  /// LOCALIZED FOR [UserTile] AND [UserPage]
  late User _user = widget.user;

  @override
  Widget build(BuildContext context) {
    User user([User? user]) {
      if (user != null) {
        // userRM(context).setState(
        //   (state) {
        //     state = user;
        //     return state;
        //   },
        // );
        // usersBloc.put(user);
      }
      return _user;
    }

    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              'ID:'.text().pad(),
              (user().id).text().pad(),
            ],
          ),
          Row(
            children: [
              'NAME: '.text().pad(),
              Expanded(
                child: TextFormField(
                  initialValue: user().name,
                  onChanged: (value) => user(user()..name = value),
                ),
              ),
            ],
          ).pad(),
          // 'CITY'.text().pad(),
          Row(
            children: [
              'PASSWORD'.text().pad(),
              Expanded(
                child: TextFormField(
                  initialValue: user().password,
                  onChanged: (value) => user(user()..password = value),
                ),
              )
            ],
          ).pad(),
          Row(
            children: [
              'EMAIL'.text().pad(),
              Expanded(
                child: TextFormField(
                  initialValue: user().email,
                  onChanged: (value) => user(user()..email = value),
                ),
              ),
            ],
          ).pad(),
          Row(
            children: [
              'ROLE'.text().pad(),
              Expanded(
                child: DropdownButton<Role>(
                  value: user().role,
                  onChanged: (role) => user(user()..role = role!),
                  items: Role.values.map(
                    (role) {
                      return DropdownMenuItem(
                        value: role,
                        child: role.name.text(),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ).pad(),
        ],
      ),
    );
  }
}
