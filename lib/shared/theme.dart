import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ideal_store/settings/settings_controller.dart';
import 'package:manager/manager.dart';

ThemeData get lightThemeData {
  return FlexThemeData.light(
    fontFamily: GoogleFonts.getFont(
            settingsBloc.font() == '' ? 'Dosis' : settingsBloc.font())
        .fontFamily,
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: settingsBloc.materialColor()),
    useMaterial3: true,
    appBarStyle: FlexAppBarStyle.primary,
    lightIsWhite: true,
    subThemesData: FlexSubThemesData(
      buttonMinSize: Size(double.maxFinite, 50),
      defaultRadius: settingsBloc.borderRadius(),
      inputDecoratorBorderType: FlexInputBorderType.outline,
    ),
    tooltipsMatchBackground: true,
  );
}

ThemeData get darkThemeData {
  return FlexThemeData.dark(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: settingsBloc.materialColor(),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    darkIsTrueBlack: true,
    fontFamily: GoogleFonts.getFont(
            settingsBloc.font() == '' ? 'Dosis' : settingsBloc.font())
        .fontFamily,
    appBarStyle: FlexAppBarStyle.primary,
    subThemesData: FlexSubThemesData(
      defaultRadius: settingsBloc.borderRadius(),
      buttonMinSize: Size(double.maxFinite, 50),
      inputDecoratorBorderType: FlexInputBorderType.outline,
    ),
    tooltipsMatchBackground: true,
  );
}

get okColor => settingsBloc.materialColor()[700];
get errorColor => settingsBloc.materialColor()[300];

Size get buttonSize => const Size(65, 65);
double get appBarHeight => 80;
List<MaterialColor> get colors => Colors.primaries;
List<ThemeMode> get themeModes => ThemeMode.values;
List<String> get fonts {
  return [
    "Azeret Mono",
    "Comfortaa",
    "DM Mono",
    "Dosis",
    "Fira Sans",
    "IBM Plex Mono",
    "Josefin Sans",
    "Montserrat",
    "Space Mono",
    "Ubuntu",
  ];
}
