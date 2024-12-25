import 'package:drift/drift.dart';

import 'orm.dart';

extension UsersDao on AppDb {
  Future<void> insertUser(String username) async {
    await into(users).insert(UsersCompanion(
      username: Value(username),
      loginTime: Value(DateTime.now()),
    ));
  }

  Stream<List<User>> watchAllUsers() {
    return select(users).watch();
  }
}
