import 'dart:async';

import 'package:ideal_store/domain/api/settings_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/home/authentication_page.dart';
import 'package:ideal_store/home/fonts_ui.dart';
import 'package:ideal_store/home/material_colors_ui.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/shared/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthenticationRepository authenticationRepository = depend();
  late SettingsRepository settingsRepository = depend();

  bool get dark => settingsRepository.dark;
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = settingsRepository.watch().listen(listener);
  }

  void onDarkChanged(bool value) => settingsRepository.toggleDark();
  void onUnauthenticated() {
    authenticationRepository.unauthenticate();
    navigator.toReplacement(AuthenticationPage());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Text(dark.toString()),
              Switch(
                value: dark,
                onChanged: onDarkChanged,
              ).pad(),
              IconButton(
                onPressed: onUnauthenticated,
                icon: Icon(Icons.exit_to_app),
              ).pad(),
            ],
          ),
          FilledButton(
            onPressed: () {},
            child: 'THEME MODE'.text(),
          ).pad(),
          FilledButton(
            onPressed: () => navigator.toDialog(FontsUI()),
            child: 'FONTS'.text(),
          ).pad(),
          FilledButton(
            onPressed: () => navigator.toDialog(MaterialColorsUI()),
            child: 'COLORS'.text(),
          ).pad(),
        ],
      ),
    );
  }
}
