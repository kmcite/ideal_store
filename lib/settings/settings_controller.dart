import 'package:ideal_store/settings/settings.dart';
import 'package:manager/manager.dart';

final settingsBloc = SettingsBloc();

class SettingsBloc {
  final settingsRM = RM.inject(() => Settings());

  Settings settings() => settingsRM.state;

  void setSettings(Settings value) => settingsRM.state = value;

  MaterialColor materialColor([MaterialColor? value]) {
    if (value != null) setSettings(settings().copyWith(materialColor: value));
    return settings().materialColor;
  }

  bool isAddCustomerVisible([bool? value]) {
    if (value != null) {
      setSettings(settings().copyWith(isAddCustomerVisible: value));
    }
    return settings().isAddCustomerVisible;
  }

  ThemeMode themeMode([ThemeMode? value]) {
    if (value != null) setSettings(settings().copyWith(themeMode: value));
    return settings().themeMode;
  }

  double borderRadius([double? value]) {
    if (value != null) setSettings(settings().copyWith(borderRadius: value));
    return settings().borderRadius;
  }

  String font([String? value]) {
    if (value != null) setSettings(settings().copyWith(font: value));
    return settings().font;
  }

  double padding([double? value]) {
    if (value != null) setSettings(settings().copyWith(padding: value));
    return settings().padding;
  }
}
