import 'package:ideal_store/main.dart';
import 'package:navigation_builder/navigation_builder.dart';

class NavigationRepository extends Repository<int> {
  final navigator = NavigationBuilder.navigate;
  late final key = navigator.navigatorKey;

  Future<T?> toReplacement<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
    String? name,
    bool fullscreenDialog = false,
    bool maintainState = true,
  }) {
    return navigator.toReplacement(
      page,
      result: result,
      name: name,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
    );
  }

  Future<T?> to<T extends Object?>(Widget page,
      {String? name,
      bool fullscreenDialog = false,
      bool maintainState = true}) {
    return navigator.to(
      page,
      name: name,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
    );
  }

  Future<T?> toDialog<T>(
    Widget dialog, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool postponeToNextFrame = false,
  }) {
    return navigator.toDialog(
      dialog,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      postponeToNextFrame: postponeToNextFrame,
    );
  }

  void back<T extends Object>([T? result]) => navigator.back(result);
}
