import 'package:ideal_store/authentication/authentication.dart';

import '../../main.dart';

class SettingsPage extends UI {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'Settings'.text(),
        actions: [
          IconButton(
            onPressed: unAuthenticate,
            icon: Icon(Icons.exit_to_app),
          ).pad(right: 8),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          FilledButton(
            onPressed: () => navigator.dialog(ThemeModesUI()),
            child: 'THEME MODE'.text(),
          ).pad(),
          FilledButton(
            onPressed: () => navigator.dialog(FontsUI()),
            child: 'FONTS'.text(),
          ).pad(),
          FilledButton(
            onPressed: () => navigator.dialog(MaterialColorsUI()),
            child: 'COLORS'.text(),
          ).pad(),
        ],
      ),
    );
  }
}
