import '../models/registry.dart';
import '../database/database_helper.dart';

class CursoEstudianteRepository {
  Future<void> insertarCurso(CursoEstudiante curso) async {
    final db = await DatabaseHelper.getDatabase();
    await db.insert('curso_estudiante', curso.toMap());
  }

  Future<List<CursoEstudiante>> obtenerCursos() async {
    final db = await DatabaseHelper.getDatabase();
    final maps = await db.query('curso_estudiante');
    return maps.map((e) => CursoEstudiante.fromMap(e)).toList();
  }
}
