import 'package:colornames/colornames.dart';
import 'package:ideal_store/settings/settings_controller.dart';
import 'package:manager/manager.dart';

import 'package:ideal_store/shared/theme.dart';

class MaterialColorsUI extends UI {
  const MaterialColorsUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Colors".text(textScaleFactor: 4).pad(),
            ],
          ),
          GridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            children: [
              for (final eachColor in colors)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: eachColor[100],
                    backgroundColor: eachColor[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        settingsBloc.borderRadius(),
                      ),
                    ),
                  ),
                  onPressed: settingsBloc.materialColor() == eachColor
                      ? null
                      : () {
                          settingsBloc.materialColor(eachColor);
                        },
                  child: eachColor.colorName.text(textScaleFactor: .8),
                ).pad(),
            ],
          ),
        ],
      ),
    );
  }
}
