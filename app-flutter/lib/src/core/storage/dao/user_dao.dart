import '../local_db.dart';
import '../../models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDAO {
  static final UserDAO instance = UserDAO();

  /// Inserta un usuario desde un JSON del backend
  Future<void> insertFromJson(Map<String, dynamic> json) async {
    final db = await LocalDB.instance.database;

    final user = UserModel.fromJson(json);

    await db.insert(
      'usuarios',
      {
        'id': user.id,
        'nombre': user.nombre,
        'correo': user.correo,
        'rol': user.rol,
        'estado': user.estado ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Inserta un usuario directamente desde el modelo
  Future<void> insertFromJs(UserModel u) async {
    final db = await LocalDB.instance.database;

    await db.insert(
      'usuarios',
      {
        'id': u.id,
        'nombre': u.nombre,
        'correo': u.correo,
        'rol': u.rol,
        'estado': u.estado ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtiene el usuario almacenado localmente
  Future<UserModel?> getUser() async {
    final db = await LocalDB.instance.database;

    final result = await db.query('usuarios', limit: 1);

    if (result.isEmpty) return null;

    final row = result.first;

    return UserModel.fromJson({
      ...row,
      'estado': row['estado'] == 1,
    });
  }

  /// Actualiza campos del usuario
  Future<void> updateUser(UserModel user) async {
    final db = await LocalDB.instance.database;

    await db.update(
      'usuarios',
      {
        'nombre': user.nombre,
        'correo': user.correo,
        'rol': user.rol,
        'estado': user.estado ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Elimina el usuario actual
  Future<void> deleteUser() async {
    final db = await LocalDB.instance.database;
    await db.delete('usuarios');
  }

  /// Limpia completamente la tabla
  Future<void> clear() async {
    final db = await LocalDB.instance.database;
    await db.delete('usuarios');
  }
}

final userDAO = UserDAO();
