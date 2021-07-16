import 'package:bonos_app_flutter_2/src/providers/personas_provider.dart';
import 'package:flutter/material.dart';

class InputPersonasPage extends StatefulWidget {
  @override
  _InputPersonasPageState createState() => _InputPersonasPageState();
}

class _InputPersonasPageState extends State<InputPersonasPage> {
  String nombre = "";
  String apellido = "";
  TextStyle estiloTexto = TextStyle(fontSize: 20);
  TextStyle estiloConfirmacion = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  bool creado = false;

  @override
  void initState() {
    creado = false;
    super.initState();
  }

  @override
  void dispose() {
    creado = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("CREAR PERSONA"),
          leading: Container(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _InputNombre(),
              _InputApellido(),
              TextButton(
                child: Text(
                  "Crear",
                  style: estiloTexto,
                ),
                onPressed: () {
                  setState(() {
                    personasProvider.agregarPersona(
                      nombre,
                      apellido,
                    );
                    print(nombre + " " + apellido);
                    if (creado == false) {
                      creado = true;
                    }
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: !creado
                    ? null
                    : Column(
                        children: [
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.purple[900].withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Persona creada con éxito",
                                style: estiloConfirmacion,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.red[900].withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Volver",
                                  style: estiloConfirmacion,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "homePage");
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ));
  }

  Padding _InputNombre() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: estiloTexto,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: "Nombre de la persona",
          labelText: "Nombre",
        ),
        onChanged: (value) {
          nombre = value;
        },
      ),
    );
  }

  Padding _InputApellido() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: estiloTexto,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: "Apellido de la persona",
          labelText: "Apellido",
        ),
        onChanged: (value) {
          apellido = value;
        },
      ),
    );
  }
}
