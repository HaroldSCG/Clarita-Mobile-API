import '../../../core/storage/local_db.dart';

class AuthLocal {
  Future<void> saveSession(String token, Map<String, dynamic> user) async {
    final db = await LocalDb.instance.database;

    // dejamos solo una sesión
    await db.delete('users');

    await db.insert('users', {
      'id': user['id'],
      'nombre': user['nombre'],
      'correo': user['correo'],
      'token': token,
    });
  }

  Future<Map<String, dynamic>?> getSession() async {
    final db = await LocalDb.instance.database;
    final rows = await db.query('users', limit: 1);
    if (rows.isEmpty) return null;
    return rows.first;
  }

  Future<void> clear() async {
    final db = await LocalDb.instance.database;
    await db.delete('users');
  }
}

final authLocal = AuthLocal();   // ← ESTA ES LA QUE FALTABA
