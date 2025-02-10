import 'package:ideal_store/application_page.dart';
import 'package:ideal_store/navigator.dart';
import 'package:ideal_store/objectbox.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ideal_store/settings/settings_controller.dart';
import 'package:manager/manager.dart';
import 'package:path/path.dart' as path;
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final dir = await getApplicationDocumentsDirectory();
  store = await openStore(
    directory: path.join(dir.path, appInfo.appName),
  );
  await RM.storageInitializer(HiveStorage());
  runApp(
    IdealStore(),
  );
}

late Store store;

class IdealStore extends UI {
  const IdealStore({super.key});

  String? get fontFamily {
    try {
      return GoogleFonts.getFont(settingsBloc.font()).fontFamily;
    } catch (e) {
      return null;
    }
  }

  @override
  void didMountWidget(BuildContext context) {
    super.didMountWidget(context);
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      home: ApplicationPage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.navigatorKey,
      // theme: FlexThemeData.light(
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: settingsBloc.materialColor(),
      //   ),
      //   subThemesData: FlexSubThemesData(
      //     defaultRadius: 10,
      //     inputDecoratorBorderType: FlexInputBorderType.outline,
      //   ),
      //   fontFamily: fontFamily,
      // ),
      // darkTheme: FlexThemeData.dark(
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: settingsBloc.materialColor(),
      //     brightness: Brightness.dark,
      //   ),
      //   subThemesData: FlexSubThemesData(
      //     defaultRadius: 10,
      //     inputDecoratorBorderType: FlexInputBorderType.outline,
      //   ),
      //   fontFamily: fontFamily,
      // ),
      themeMode: settingsBloc.themeMode(),
    );
  }
}

class AppBloc {
  final indexRM = RM.inject(() => 0);
  int get index => indexRM.state;
  setIndex(int i) => indexRM.state = i;
}

final appBloc = AppBloc();
