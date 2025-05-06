class Student {
  int? id;
  String nombre;
  int? edad;

  Student({this.id, required this.nombre, required this.edad});

  //Mapea usuario
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'edad':edad
    };
  }

  //Usuario desde Map
  factory Student.fromMap(Map<String, dynamic> map){
    return Student(
      id: map['id'],
      nombre: map['nombre'],
      edad: map['edad']
    );
  }
}