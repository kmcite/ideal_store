import 'package:ideal_store/authentication/authentication.dart';
import 'package:ideal_store/main.dart';

class UsersPage extends UI {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'USERS'.text(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                'Products'.text(textScaleFactor: 3).pad(),
                ElevatedButton(
                  onPressed: switch (customers()) {
                    [] => null,
                    [...] => removeAllCustomers,
                  },
                  child: 'DELETE ALL PRODUCTS'.text(),
                ).pad(),
                'Customers'.text(textScaleFactor: 3).pad(),
                ElevatedButton(
                  onPressed: switch (customers()) {
                    [] => null,
                    [...] => removeAllCustomers,
                  },
                  child: 'DELETE ALL CUSTOMERS'.text(),
                ).pad(),
              ],
            ),
            switch (users().isEmpty) {
              true =>
                'Users are not available'.text(textScaleFactor: 2.3).pad(),
              false => ListView.builder(
                  // separatorBuilder: (context, index) =>
                  //     Divider(thickness: 1, color: Colors.blueGrey, height: 1),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: users().length,
                  itemBuilder: (_, i) {
                    return CustomerTile();
                  },
                ),
            },
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add customer',
        child: const Icon(Icons.add_reaction),
        onPressed: () {
          navigator.dialog(AddUserDialog());
        },
      ).pad(),
    );
  }
}

class CustomerTile extends UI {
  const CustomerTile({super.key});

  @override
  Widget build(BuildContext context) {
    User customer([User? user]) {
      if (user != null) users(user);
      return users().firstWhere((user) => user.id == editCustomerRM.state);
    }

    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              'ID:'.text().pad(),
              (customer().id).text().pad(),
            ],
          ),
          Row(
            children: [
              'NAME: '.text().pad(),
              (customer().name).text(textScaleFactor: 2).pad(),
              Expanded(
                child: TextFormField(
                  initialValue: customer().name,
                  onChanged: (value) => customer(customer()..name = value),
                ),
              ),
            ],
          ),
          'CITY'.text().pad(),
          Row(
            children: [
              'PASSWORD'.text().pad(),
              Expanded(
                child: TextFormField(
                  initialValue: customer().password,
                  onChanged: (value) => customer(customer()..password = value),
                ),
              )
            ],
          ),
          Row(
            children: [
              'EMAIL'.text().pad(),
              Expanded(
                child: TextFormField(
                  initialValue: customer().email,
                  onChanged: (value) => customer(customer()..email = value),
                ),
              ),
            ],
          ),
          Row(
            children: [
              'ROLE'.text().pad(),
              Expanded(
                child: DropdownButton<Role>(
                  value: customer().role,
                  onChanged: (role) => customer(customer()..role = role!),
                  items: Role.values
                      .map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: role.name.text(),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final _userToAddRM = RM.inject(
  () {
    return User();
  },
);

User get userToAdd => _userToAddRM.state;
set userToAdd(User user) {
  _userToAddRM
    ..state = user
    ..notify();
}

class AddUserDialog extends UI {
  const AddUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'NEW USER'.text(textScaleFactor: 3).pad(),
          TextFormField(
            initialValue: userToAdd.name,
            decoration: InputDecoration(
              labelText: 'USER NAME',
            ),
            onChanged: (value) => userToAdd = userToAdd..name = value,
          ).pad(),
          TextFormField(
            initialValue: userToAdd.password,
            onChanged: (value) => userToAdd = userToAdd..password = value,
            decoration: InputDecoration(
              labelText: 'PASSWORD',
            ),
            obscureText: true,
          ).pad(),
          TextFormField(
            initialValue: userToAdd.email,
            onChanged: (value) => userToAdd = userToAdd..email = value,
            decoration: InputDecoration(
              labelText: 'EMAIL',
            ),
          ).pad(),
          Row(
            children: Role.values.map(
              (role) {
                return Expanded(
                  child: FilledButton(
                    onPressed: userToAdd.role == role
                        ? null
                        : () {
                            userToAdd = userToAdd..role = role;
                          },
                    child: role.name.toUpperCase().text(),
                  ).pad(),
                );
              },
            ).toList(),
          ),
          FilledButton(
            onPressed: () {
              users(userToAdd);
              userToAdd = User();
            },
            child: 'SAVE'.text(),
          ).pad(),
        ],
      ),
    );
  }
}
