import 'package:manager/manager.dart';

import '../shared/theme.dart';
import 'settings_controller.dart';

class FontsUI extends UI {
  const FontsUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Fonts".text(textScaleFactor: 4).pad(),
            ],
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (final String eachFont in fonts)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: settingsBloc.materialColor()[100],
                    backgroundColor: settingsBloc.materialColor()[900],
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(settingsBloc.borderRadius()),
                    ),
                  ),
                  onPressed: switch (settingsBloc.font() == eachFont) {
                    false => () {
                        settingsBloc.font(eachFont);
                      },
                    true => null,
                  },
                  child: eachFont.text(),
                ).pad(),
            ],
          ),
        ],
      ),
    );
  }
}
