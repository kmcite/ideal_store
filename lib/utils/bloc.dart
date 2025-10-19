import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart' as m;
import 'package:ideal_store/utils/navigator.dart';

import '../main.dart';

mixin _Bloc<W extends StatefulWidget> on m.State<W> {
  final _subscriptions = <Type, StreamSubscription>{};

  T depend<T extends Repository>() {
    final repo = repositories[T];
    if (repo == null) throw Exception('Repository $T not found');

    // cancel old sub if exists
    _subscriptions[T]?.cancel();

    // listen again
    _subscriptions[T] = repo.watch().listen(listener);

    log('$W depends on $T (${_subscriptions.length} active)');
    return repo as T;
  }

  @override
  void dispose() {
    for (final sub in _subscriptions.values) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }

  void listener(_) {
    if (mounted) setState(() {});
  }

  late NavigationRepository navigator = depend();
  GlobalKey<NavigatorState> get key => navigator.key;
}
abstract class State<U extends StatefulWidget> = m.State<U> with _Bloc<U>;

extension NavigatorX on StatelessWidget {
  NavigationRepository get navigator =>
      repositories[NavigationRepository] as NavigationRepository;
}
