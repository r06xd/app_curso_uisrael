import 'package:examen_semana_4/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  final dbPath = await getDatabasesPath();
  await deleteDatabase(join(dbPath, 'examen4semana.db')); // Elimina la BD vieja
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Login(),
      )
    );
  }
}

