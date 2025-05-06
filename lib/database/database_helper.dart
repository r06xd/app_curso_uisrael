import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static Database ? _database;

static Future<Database> getDatabase() async {
  if(_database != null) return _database!;

  //Define la ruta del archivo
  final String pathDB = join (await getDatabasesPath(), 'examen4semana.db');

  _database = await openDatabase(
    pathDB,
    version: 1,
    onCreate: (db, version) async{
      var batch = db.batch();

      batch.execute("DROP TABLE IF EXISTS usuarios;");
      batch.execute("CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario TEXT, pass TEXT);");
      batch.execute("INSERT INTO usuarios(usuario,pass) VALUES('Admin','Admin');");
      batch.execute("CREATE TABLE estudiantes(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, edad INTEGER);");
      batch.execute("CREATE TABLE curso_estudiante(id INTEGER PRIMARY KEY AUTOINCREMENT, id_estudiante INTEGER, fecha_registro TEXT, pais TEXT, ciudad TEXT, valor_curso TEXT, cuota_inicial TEXT, cuota_mensual TEXT, valor_final TEXT);");
      await batch.commit();
    }
  );
  return _database!;
}
}