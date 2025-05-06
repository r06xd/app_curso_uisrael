import 'package:examen_semana_4/database/database_helper.dart';
import 'package:examen_semana_4/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository{
  Future<void> insertarUsuario(User usuario) async {
    final db = await DatabaseHelper.getDatabase();
    await db.insert(
      'usuarios', 
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
      );
  }

  Future<List<User>> obtenerUsuarios() async {
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');

    return List.generate(maps.length, (i){
      return User.fromMap(maps[i]);
    });
  }

  Future<void> actualizarUsuario(User usuario) async {
    final db= await DatabaseHelper.getDatabase();
    await db.update('usuarios',
    usuario.toMap(),
    where: 'id=?',whereArgs: [usuario.id]
    );
  }

  Future<void> eliminarUsuario(int id) async {
    final db = await DatabaseHelper.getDatabase();
    await db.delete('usuarios',where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> validarUsuario(String usuario, String pass) async {
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'usuario = ? and pass = ?',
      whereArgs: [usuario,pass]
    );
    return maps.isNotEmpty;
  }
}