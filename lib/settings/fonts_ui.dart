import 'package:ideal_store/main.dart';

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
                    foregroundColor: settingsRM.materialColor()[100],
                    backgroundColor: settingsRM.materialColor()[900],
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(settingsRM.borderRadius()),
                    ),
                  ),
                  onPressed: switch (settingsRM.font() == eachFont) {
                    false => () {
                        settingsRM.font(eachFont);
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
