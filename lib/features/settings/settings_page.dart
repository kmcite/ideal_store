import 'package:forui/forui.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/settings_repository.dart';
import 'package:ideal_store/features/settings/authentication_page.dart';
import 'package:ideal_store/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthenticationRepository authenticationRepository = depend();
  late SettingsRepository settingsRepository = depend();

  bool get dark => settingsRepository.dark;

  void onDarkChanged(bool value) => settingsRepository.toggleDark();
  void onUnauthenticated() {
    authenticationRepository.unauthenticate();
    navigator.toReplacement(AuthenticationPage());
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Settings'),
      ),
      child: FTileGroup(
        children: [
          FTile(
            title: Text('Darkness'),
            suffix: Icon(dark ? Icons.dark_mode : Icons.light_mode),
            onPress: () => onDarkChanged(dark),
          ),
          FTile(
            title: Text('Logout'),
            suffix: Icon(Icons.logout),
            onPress: onUnauthenticated,
          ),
        ],
        label: Text('Configuration'),
        description: Text('Configure darkness and logout'),
      ),
    );
  }
}
