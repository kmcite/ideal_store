import 'package:ideal_store/authentication/authentication_bloc.dart';
import 'package:ideal_store/authentication/authentication_page.dart';
import 'package:ideal_store/customer/customer_part.dart';
import 'package:ideal_store/main.dart';
import 'package:ideal_store/navigator.dart';
import 'package:manager/manager.dart';

class ApplicationPage extends UI {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (authenticationBloc.isCustomer) {
      return CustomerServices();
    }
    if (authenticationBloc.isAdmin) return AdminServices();
    return AuthenticationPage();
  }
}

class AdminServices extends UI {
  const AdminServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: appBloc.index,
            onDestinationSelected: appBloc.setIndex,
            labelType: NavigationRailLabelType.all,
            destinations: [
              ...NavigationTargets.values.where(
                (target) {
                  return target.isNotAdmin || authenticationBloc.isAdmin;
                },
              ).map(
                (target) {
                  return NavigationRailDestination(
                    icon: Icon(target.icon),
                    label: Text(target.label),
                  );
                },
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: appBloc.index,
              children: NavigationTargets.values.where(
                (target) {
                  return target.isNotAdmin || authenticationBloc.isAdmin;
                },
              ).map(
                (target) {
                  return target.page;
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
