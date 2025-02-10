import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:ideal_store/navigator.dart';
import 'package:ideal_store/settings/fonts_ui.dart';
import 'package:ideal_store/settings/material_colors_ui.dart';
import 'package:ideal_store/settings/theme_modes_ui.dart';
import 'package:manager/manager.dart';

import '../dashboard/app_drawer.dart';

class SettingsPage extends UI {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: 'Settings'.text(),
        actions: [
          IconButton(
            onPressed: authenticationBloc.unAuthenticate,
            icon: Icon(Icons.exit_to_app),
          ).pad(right: 8),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          FilledButton(
            onPressed: () => navigator.toDialog(ThemeModesUI()),
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
