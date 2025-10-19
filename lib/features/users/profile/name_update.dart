import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/main.dart';

class NameUpdateDialog extends StatefulWidget {
  const NameUpdateDialog({super.key});
  @override
  State<NameUpdateDialog> createState() => _NameUpdateDialogState();
}

class _NameUpdateDialogState extends State<NameUpdateDialog> {
  late UsersRepository usersRepository = depend();
  late AuthenticationRepository authenticationRepository = depend();
  late final name = TextEditingController(text: user?.name)
    ..addListener(() => listener(null));
  User? get user {
    final id = authenticationRepository.currentUser?.id;
    if (id == null) return null;
    return usersRepository.get(id);
  }

  void onSaved() {
    usersRepository.put(user!..name = name.text);
    navigator.back();
  }

  void onCancelled() {
    navigator.back();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text("Update Name"),
      body: Column(
        children: [
          Text(user!.name),
          FTextField(
            controller: name,
            label: Text("Name"),
          ),
        ],
      ),
      direction: Axis.horizontal,
      actions: [
        FButton(
          onPress: onSaved,
          child: Text('Save'),
        ),
        FButton(
          style: FButtonStyle.destructive(),
          onPress: onCancelled,
          child: Text('Cancel'),
        )
      ],
    );
  }
}
