import 'package:ideal_store/main.dart';
import 'package:ideal_store/shared/utils.dart';

class ThemeModesUI extends StatefulWidget {
  const ThemeModesUI({super.key});

  @override
  State<ThemeModesUI> createState() => _ThemeModesUIState();
}

class _ThemeModesUIState extends State<ThemeModesUI> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          'Modes'.text(textScaleFactor: 4).pad(),
          // ...ThemeMode.values.map(
          //   (mode) {
          //     return ElevatedButton(
          //       onPressed: settingsBloc.themeMode() == mode
          //           ? null
          //           : () {
          //               settingsBloc.themeMode(mode);
          //             },
          //       child: Icon(
          //         mode.icon,
          //         size: 80,
          //       ).pad(),
          //     ).pad();
          //   },
          // ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              navigator.back();
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
