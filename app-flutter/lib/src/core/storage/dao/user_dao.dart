import '../local_db.dart';

class UserDao {
  Future<Map<String, dynamic>?> getUser() async {
    final db = await LocalDb.instance.database;
    final rows = await db.query('users', limit: 1);
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> saveUser(Map<String, dynamic> data) async {
    final db = await LocalDb.instance.database;
    await db.delete('users');
    await db.insert('users', data);
  }

  Future<void> clearUser() async {
    final db = await LocalDb.instance.database;
    await db.delete('users');
  }
}

final userDao = UserDao();
