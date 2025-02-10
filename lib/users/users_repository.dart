import 'package:ideal_store/main.dart';
import 'package:ideal_store/users/authentication.dart';

class UsersRepository {
  final _users = store.box<User>();
  late final put = _users.put;
  late final getAll = _users.getAll;
  late final get = _users.get;
  late final remove = _users.remove;
  late final removeAll = _users.removeAll;
  late final getAllAsync = _users.getAllAsync;
  late final query = _users.query;
}

final usersRepository = UsersRepository();
