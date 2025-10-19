import 'package:ideal_store/main.dart';

class SettingsRepository extends HiveRepository<bool> {
  SettingsRepository() {
    try {
      final i = get('dark');
      dark = i == '1';
      notify();
    } catch (e) {
      save('dark', '1');
      dark = true;
    }
  }

  late bool dark;

  void toggleDark() {
    dark = !dark;
    notify();
  }

  @override
  void notify() {
    super.notify();
    save('dark', dark ? '1' : '0');
  }

  void setDark(bool _dark) {
    dark = _dark;
    notify();
  }
}
