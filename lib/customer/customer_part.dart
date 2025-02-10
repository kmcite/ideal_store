import 'package:ideal_store/main.dart';
import 'package:ideal_store/navigator.dart';
import 'package:manager/manager.dart';

class CustomerServices extends StatelessWidget {
  const CustomerServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationTargets.values.elementAt(appBloc.index).page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: appBloc.index,
        onDestinationSelected: appBloc.setIndex,
        destinations: NavigationTargets.values.map(
          (target) {
            return NavigationDestination(
              icon: Icon(target.icon),
              label: target.label,
            );
          },
        ).toList(),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
    );
  }
}
