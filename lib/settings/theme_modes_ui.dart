import '../main.dart';

class ThemeModesUI extends UI {
  const ThemeModesUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          'Modes'.text(textScaleFactor: 4).pad(),
          ...ThemeMode.values.map(
            (mode) {
              return ElevatedButton(
                onPressed: settingsRM.themeMode() == mode
                    ? null
                    : () {
                        settingsRM.themeMode(mode);
                      },
                child: Icon(
                  mode.icon,
                  size: 80,
                ).pad(),
              ).pad();
            },
          ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              navigator.pop();
            },
            child: Icon(
              Icons.arrow_back,
              size: 80,
            ).pad(),
          ).pad()
        ],
      ),
    );
  }
}

extension on ThemeMode {
  IconData get icon {
    switch (this) {
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.system:
        return Icons.settings_system_daydream;
      default:
        return Icons.error;
    }
  }
}
