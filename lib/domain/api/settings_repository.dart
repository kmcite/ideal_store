import 'dart:async';
import 'package:ideal_store/domain/api/repository.dart';

class SettingsRepository extends Repository<bool> {
  SettingsRepository() {
    controller.add(0);
  }

  int _count = 0;
  void notifyListeners() => controller.add(_count + 1);
  final controller = StreamController<int>.broadcast();

  bool dark = false;

  void toggleDark() {
    dark = !dark;
    notifyListeners();
  }

  void setDark(bool _dark) {
    dark = _dark;
    notifyListeners();
  }

  Stream<int> watch() => controller.stream;
  // Stream<bool> watchDark() => controller.stream.map((_) => dark);
}
