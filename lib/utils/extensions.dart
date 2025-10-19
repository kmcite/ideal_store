import 'package:ideal_store/main.dart';

// final imageRM = RM.injectFuture(
//   () async => Uint8List.sublistView(
//     await rootBundle.load('assets/icon.png'),
//   ),
// );

extension TextX on dynamic {
  Widget text({double textScaleFactor = 1}) => Text(
        toString(),
        // ignore: deprecated_member_use
        textScaleFactor: textScaleFactor,
      );
}

extension PadX on Widget {
  Padding pad() => Padding(
        padding: EdgeInsets.all(8),
        child: this,
      );
}
