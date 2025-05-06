import 'package:examen_semana_4/pages/registry_student.dart';
import 'package:examen_semana_4/repository/usuario_repository.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

@override
  Widget build(BuildContext context) {
    final UserRepository _usuarioRepostitory = UserRepository();
    TextEditingController _usuario =  TextEditingController();
    TextEditingController _pass =  TextEditingController();

    // TODO: implement build
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/UISRAEL.png',
            width: 150,
            height: 150,
          ),
          SizedBox(
            height: 50,
            width:300,
            child: TextField(
            controller: _usuario,
            decoration: InputDecoration(
              labelText: "Usuario",
              border: OutlineInputBorder()
            ),
          )
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width:300,  
            child: TextField(
            controller: _pass,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder()
            ),
          ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed:() async => {
                  if(await _usuarioRepostitory.validarUsuario(_usuario.text, _pass.text))
                  {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=> const RegistryStudent())
                      )
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('El usuario no existe'), 
                        duration: Duration(seconds: 2),
                        )
                    )
                  }
                }, 
                child: Text("Ingresar")
                )
            ]
          )
        ],
      )
    );
    
    
  }
}