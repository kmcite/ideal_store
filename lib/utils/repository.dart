import 'dart:async';
import 'dart:developer' show log;

abstract class Repository<T> {
  S service<S>() {
    try {
      log('${S} serves $runtimeType');
      return services[S] as S;
    } catch (e) {
      throw 'Service ${S} not found for $runtimeType';
    }
  }

  final controller = StreamController<int>.broadcast();
  Stream<int> watch() => controller.stream;

  void notify() {
    controller.add(1);
  }
}

final repositories = <Type, Repository>{};
void repository<T extends Repository>(T instance) {
  repositories[T] = instance;
  log('Repository | ${T}');
}

final services = <Type, dynamic>{};

void service<T>(T instance) {
  if (instance is Future || instance is Stream) {
    throw 'Can not service a Future or Stream';
  }
  services[T] = instance;
  log('Service | ${T}');
}
