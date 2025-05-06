class CursoEstudiante {
  int? id;
  int? idEstudiante;
  String fechaRegistro;
  String pais;
  String ciudad;
  String valorCurso;
  String cuotaInicial;
  String cuotaMensual;
  String valorFinal;

  CursoEstudiante({
      this.id, 
      required this.idEstudiante, 
      required this.fechaRegistro,
      required this.pais,
      required this.ciudad,
      required this.valorCurso,
      required this.cuotaInicial,
      required this.cuotaMensual,
      required this.valorFinal
      });

  //Mapea usuario
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'id_estudiante':idEstudiante,
      'fecha_registro':fechaRegistro,
      'pais':pais,
      'ciudad':ciudad,
      'valor_curso':valorCurso,
      'cuota_inicial':cuotaInicial,
      'cuota_mensual':cuotaMensual,
      'valor_final':valorFinal,
    };
  }

  //Usuario desde Map
  factory CursoEstudiante.fromMap(Map<String, dynamic> map){
    return CursoEstudiante(
      id: map['id'],
      idEstudiante: map['id_estudiante'],
      fechaRegistro: map['fecha_registro'],
      pais: map['pais'],
      ciudad: map['ciudad'],
      valorCurso: map['valorCurso'],
      cuotaInicial: map['cuotaInicial'],
      cuotaMensual: map['cuotaMensual'],
      valorFinal: map['valorFinal']
    );
  }
}