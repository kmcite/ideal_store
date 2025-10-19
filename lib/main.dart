import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ideal_store/domain/api/authentication_repository.dart';
import 'package:ideal_store/domain/api/categories_repository.dart';
import 'package:ideal_store/domain/api/orders_repository.dart';
import 'package:ideal_store/domain/api/products_repository.dart';
import 'package:ideal_store/domain/api/settings_repository.dart';
import 'package:ideal_store/domain/api/users_repository.dart';
import 'package:ideal_store/features/settings/authentication_page.dart';
import 'package:ideal_store/features/home/home_page.dart';
import 'package:ideal_store/features/users/authentication.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/utils/navigator.dart';
import 'package:ideal_store/objectbox.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

export 'package:flutter/material.dart' hide State;
export 'package:ideal_store/utils/bloc.dart';
export 'package:ideal_store/utils/repository.dart';
export 'package:ideal_store/utils/rehive.dart';
export 'package:ideal_store/utils/crud.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final path = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: join(path.path, appInfo.appName));
  await Hive.initFlutter(appInfo.appName);
  final box = await Hive.openBox(appInfo.appName);

  service(store);
  service(box);

  /// REPOSITORIES
  repository(NavigationRepository());
  repository(CategoriesRepository());
  repository(ProductsRepository());
  repository(OrdersRepository());
  repository(AuthenticationRepository());
  repository(UsersRepository());
  repository(SettingsRepository());

  runApp(
    IdealStore(),
  );
}

class IdealStore extends StatefulWidget {
  const IdealStore({super.key});

  @override
  State<IdealStore> createState() => _IdealStoreState();
}

class _IdealStoreState extends State<IdealStore> {
  late SettingsRepository settingsRepository = depend();
  late AuthenticationRepository authenticationRepository = depend();

  bool get dark => settingsRepository.dark;
  User? get currentUser => authenticationRepository.currentUser;

  bool get authenticated => currentUser != null;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    settingsRepository.watch().listen(listener);
    authenticationRepository.watch().listen(listener);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: key,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => FTheme(
        data: dark ? FThemes.yellow.dark : FThemes.green.light,
        child: child!,
      ),
      home: authenticated ? HomePage() : AuthenticationPage(),
      theme: dark ? ThemeData.dark() : ThemeData(),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
    );
  }
}
