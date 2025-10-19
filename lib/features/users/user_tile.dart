import 'package:forui/forui.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/features/users/authentication.dart';

class UserTile extends StatefulWidget with FTileGroupMixin {
  final User user;
  const UserTile(this.user, {super.key});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  /// LOCALIZED FOR [UserTile] AND [UserPage]
  late User user = widget.user;

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      label: Text("${user.id}. ${user.name}"),
      children: [
        FTile(
          title: Text('${user.city.cityName}'),
        ),
        FTile(
          title: Text('${user.email}'),
        ),
        FTile(
          title: Text('${user.role}'),
        ),
        FTile(
          title: Text('${user.password}'),
        ),
      ],
    );
    // return Container(
    //   margin: EdgeInsets.all(8),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Colors.grey),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: Column(
    //     children: [
    //       // 'CITY'.text().pad(),
    //       Row(
    //         children: [
    //           'PASSWORD'.text().pad(),
    //           Expanded(
    //             child: FTextField(
    //               initialText: user().password,
    //               onChange: (value) => user(user()..password = value),
    //             ),
    //           )
    //         ],
    //       ).pad(),
    //       Row(
    //         children: [
    //           'EMAIL'.text().pad(),
    //           Expanded(
    //             child: FTextField(
    //               initialText: user().email,
    //               onChange: (value) => user(user()..email = value),
    //             ),
    //           ),
    //         ],
    //       ).pad(),
    //       // Row(
    //       //   children: [
    //       //     'ROLE'.text().pad(),
    //       //     // Expanded(
    //       //     //   child: DropdownButton<Role>(
    //       //     //     value: user().role,
    //       //     //     onChanged: (role) => user(user()..role = role!),
    //       //     //     items: Role.values.map(
    //       //     //       (role) {
    //       //     //         return DropdownMenuItem(
    //       //     //           value: role,
    //       //     //           child: role.name.text(),
    //       //     //         );
    //       //     //       },
    //       //     //     ).toList(),
    //       //     //   ),
    //       //     // ),
    //       //   ],
    //       // ).pad(),
    //     ],
    //   ),
    // );
  }
}
