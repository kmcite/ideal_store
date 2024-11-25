import '../main.dart';

final imageRM = RM.injectFuture(
  () async => Uint8List.sublistView(
    await rootBundle.load('assets/icon.png'),
  ),
);
