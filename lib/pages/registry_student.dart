import 'package:examen_semana_4/models/registry.dart';
import 'package:examen_semana_4/pages/summary.dart';
import 'package:examen_semana_4/repository/registry_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegistryStudent extends StatefulWidget {
  const RegistryStudent({super.key});

  @override
  _RegistryStudentState createState() => _RegistryStudentState();
}

class _RegistryStudentState extends State<RegistryStudent> {
  DateTime? _fechaSeleccionada;
  String? _paisSeleccionado;
  String? _ciudadSeleccionada;

  final _valorCurso = 1500.0;
  final _cuotaInicialController = TextEditingController();
  final _cuotaMensualController = TextEditingController();
  final _nombresController = TextEditingController();
  final _edadController = TextEditingController();

  Map<String, List<String>> ciudadesPorPais = {
    'Ecuador': ['Quito', 'Guayaquil'],
    'Perú': ['Lima', 'Cusco'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro de estudiantes',
          style: TextStyle(color: Colors.blue, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Fecha
              Row(
                children: [
                  const Text('Fecha: '),
                  TextButton(
                    onPressed: _seleccionarFecha,
                    child: Text(
                      _fechaSeleccionada == null
                          ? 'Seleccionar fecha'
                          : _fechaSeleccionada.toString().split(' ')[0],
                    ),
                  ),
                ],
              ),
              // País
              Row(
                children: [
                  const Text('País: '),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: _paisSeleccionado,
                    hint: const Text('Seleccione un país'),
                    onChanged: (value) {
                      setState(() {
                        _paisSeleccionado = value;
                        _ciudadSeleccionada = null;
                      });
                    },
                    items:
                        ciudadesPorPais.keys
                            .map(
                              (pais) => DropdownMenuItem(
                                value: pais,
                                child: Text(pais),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
              // Ciudad
              Row(
                children: [
                  const Text('Ciudad: '),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _ciudadSeleccionada,
                    hint: const Text('Seleccione una ciudad'),
                    onChanged: (value) {
                      setState(() {
                        _ciudadSeleccionada = value;
                      });
                    },
                    items:
                        (ciudadesPorPais[_paisSeleccionado] ?? [])
                            .map<DropdownMenuItem<String>>(
                              (ciudad) => DropdownMenuItem<String>(
                                value: ciudad,
                                child: Text(ciudad),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Valor curso fijo
              Row(
                children: [
                  const Text('Valor del curso: '),
                  const SizedBox(width: 10),
                  Text(_valorCurso.toStringAsFixed(2)),
                ],
              ),
              // Cuota inicial
              Row(
                children: [
                  const Text('Cuota inicial: '),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _cuotaInicialController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _calcularCuotas,
                    child: const Text('Calcular cuotas'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Cuota mensual
              Row(
                children: [
                  const Text('Cuota mensual: '),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _cuotaMensualController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Nombres y edad
              Row(
                children: [
                  const Text('Nombres: '),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _nombresController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Edad: '),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _edadController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
                            const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _guardarYMostrarResumen,
                  child: const Text('Guardar y Ver Resumen'),
                ),
              )

            ],
          ),
        ),
      ),
    );
    
  }

  void _seleccionarFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
      });
    }
  }

  void _calcularCuotas() {
    double cuotaInicial = double.tryParse(_cuotaInicialController.text) ?? 0.0;
    double mensual = (_valorCurso - cuotaInicial) / 4;
    setState(() {
      _cuotaMensualController.text = mensual.toStringAsFixed(2);
    });
  }

  void _guardarYMostrarResumen() async {
  if (_fechaSeleccionada == null ||
      _paisSeleccionado == null ||
      _ciudadSeleccionada == null ||
      _cuotaInicialController.text.isEmpty ||
      _cuotaMensualController.text.isEmpty ||
      _nombresController.text.isEmpty ||
      _edadController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, complete todos los campos')),
    );
    return;
  }

  final nombre = _nombresController.text;
  final edad = int.tryParse(_edadController.text) ?? 0;
  final cuotaInicial = _cuotaInicialController.text;
  final cuotaMensual = _cuotaMensualController.text;
  final fecha = _fechaSeleccionada.toString().split(' ')[0];

  // Inserta estudiante (tú puedes enlazar con EstudianteRepository si quieres guardar también)
  final curso = CursoEstudiante(
    idEstudiante: 1, // puedes cambiarlo si estás vinculando con estudiante real
    fechaRegistro: fecha,
    pais: _paisSeleccionado!,
    ciudad: _ciudadSeleccionada!,
    valorCurso: _valorCurso.toStringAsFixed(2),
    cuotaInicial: cuotaInicial,
    cuotaMensual: cuotaMensual,
    valorFinal: (_valorCurso).toStringAsFixed(2),
  );

  await CursoEstudianteRepository().insertarCurso(curso);

  // Ir a la pantalla de resumen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SymmaryStudent(
        nombre: nombre,
        ciudad: curso.ciudad,
        cuotaInicial: double.parse(cuotaInicial),
        cuotaMensual: double.parse(cuotaMensual),
        edad: edad,
        fecha: fecha,
        pais: curso.pais,),
    ),
  );
}

}
