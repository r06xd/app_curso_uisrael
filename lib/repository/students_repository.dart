import '../models/student.dart';
import '../database/database_helper.dart';

class EstudianteRepository {
  Future<void> insertarEstudiante(Student estudiante) async {
    final db = await DatabaseHelper.getDatabase();
    await db.insert('estudiantes', estudiante.toMap());
  }

  Future<List<Student>> obtenerEstudiantes() async {
    final db = await DatabaseHelper.getDatabase();
    final maps = await db.query('estudiantes');
    return maps.map((e) => Student.fromMap(e)).toList();
  }
}
