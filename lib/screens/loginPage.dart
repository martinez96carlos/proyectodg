import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import './homePage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
        ),
    );

  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post(
      "$SERVER_IP/login",
      body: {
        "username": username,
        "password": password
      }
    );
    if(res.statusCode == 200) { 
      return res.body;
    }
    return null;
  }

  Future<int> attemptSignUp(String username, String password) async {
    var res = await http.post(
      '$SERVER_IP/signup',
      body: {
        "username": username,
        "password": password
      }
    );
    return res.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico'
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña'
              ),
            ),
            FlatButton(
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;
                var jwt = await attemptLogIn(username, password);
                if(jwt != null) {
                  storage.write(key: "jwt", value: jwt);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage.fromBase64(jwt)
                    )
                  );
                } else {
                  displayDialog(context, "Ocurrió un Error", "No se encontró ninguna cuenta con ese correo.");
                }
              },
              child: Text("Iniciar Sesión")
            ),
            FlatButton(
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;

                if(username.length < 4) 
                  displayDialog(context, "Usuario Inválido", "------");
                else if(password.length < 4) 
                  displayDialog(context, "Contraseña Inválida", "La contraseña debe tener al menos 4 caracteres.");
                else{
                  var res = await attemptSignUp(username, password);
                  if(res == 201)
                    displayDialog(context, "Éxito", "El usuario fue creado. Iniciar Sesión ahora.");
                  else if(res == 409)
                    displayDialog(context, "Ese nombre de Usuario ya existe", "Por favor usa otro correo.");  
                  else {
                    displayDialog(context, "Error", "Surgió un error desconocido.");
                  }
                }
              },
              child: Text("Registrarse")
            )
          ],
        ),
      )
    );
  }
}