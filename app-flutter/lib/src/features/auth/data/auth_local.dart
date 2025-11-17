import '../../../core/storage/dao/user_dao.dart';
import '../../../core/storage/local_db.dart';
import 'package:sqflite/sqflite.dart';
class AuthLocal {
  Future<void> saveToken(String token) async {
    final db = await LocalDB.instance.database;
    await db.insert(
      "auth",
      {"id": 1, "token": token},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getToken() async {
    final db = await LocalDB.instance.database;
    final res = await db.query("auth", where: "id = 1");
    if (res.isEmpty) return null;
    return res.first["token"] as String?;
  }

  Future<void> deleteToken() async {
    final db = await LocalDB.instance.database;
    await db.delete("auth", where: "id = 1");
  }

  Future<void> saveUser(Map<String, dynamic> json) async {
    await userDAO.insertFromJson(json);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final user = await userDAO.getUser();
    return user?.toJson();
  }
}

final authLocal = AuthLocal();