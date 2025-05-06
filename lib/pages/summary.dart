import 'package:flutter/material.dart';

class SymmaryStudent extends StatelessWidget {
  final String nombre;
  final int edad;
  final String fecha;
  final String ciudad;
  final String pais;
  final double cuotaInicial;
  final double cuotaMensual;

  SymmaryStudent({
    required this.nombre,
    required this.edad,
    required this.fecha,
    required this.ciudad,
    required this.pais,
    required this.cuotaInicial,
    required this.cuotaMensual,
  });

  @override
  Widget build(BuildContext context) {
    double valorFinal = cuotaInicial + (cuotaMensual * 4);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Estudiante'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(140),
          },
          border: TableBorder.all(color: Colors.black26),
          children: [
            _crearFila('Nombres:', nombre),
            _crearFila('Edad:', edad.toString()),
            _crearFila('Fecha:', fecha),
            _crearFila('Ciudad:', ciudad),
            _crearFila('País:', pais),
            _crearFila('Cuota inicial:', '\$${cuotaInicial.toStringAsFixed(2)}'),
            _crearFila('Cuota mensual:', '\$${cuotaMensual.toStringAsFixed(2)}'),
            _crearFila('Valor final:', '\$${valorFinal.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  TableRow _crearFila(String titulo, String valor) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(valor),
      ),
    ]);
  }
}
