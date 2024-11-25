import 'package:ideal_store/main.dart';

final settingsRM = SettingsRM();

class SettingsRM {
  final settingsRM = rms(Settings());

  Settings settings([Settings? settings]) {
    if (settings != null) settingsRM.state = settings;
    return settingsRM.state;
  }

  MaterialColor materialColor([MaterialColor? value]) {
    if (value != null) settings(settings().copyWith(materialColor: value));
    return settings().materialColor;
  }

  bool isAddCustomerVisible([bool? value]) {
    if (value != null) {
      settings(settings().copyWith(isAddCustomerVisible: value));
    }
    return settings().isAddCustomerVisible;
  }

  ThemeMode themeMode([ThemeMode? value]) {
    if (value != null) settings(settings().copyWith(themeMode: value));
    return settings().themeMode;
  }

  double borderRadius([double? value]) {
    if (value != null) settings(settings().copyWith(borderRadius: value));
    return settings().borderRadius;
  }

  String font([String? value]) {
    if (value != null) settings(settings().copyWith(font: value));
    return settings().font;
  }

  double padding([double? value]) {
    if (value != null) settings(settings().copyWith(padding: value));
    return settings().padding;
  }
}
