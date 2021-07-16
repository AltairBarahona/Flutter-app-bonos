import 'package:bonos_app_flutter_2/src/models/persona_model.dart';
import 'package:bonos_app_flutter_2/src/providers/personas_provider.dart';
import 'package:flutter/material.dart';

import '../models/bono_model.dart';
import '../providers/bonos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nombre = "";
  String apellido = "";
  String idPersonaSelecciona = "";
  String bonoSeleccionado = "";
  bool seleccionar = false;

  @override
  void initState() {
    nombre = "";
    apellido = "";
    idPersonaSelecciona = "";
    bonoSeleccionado = "";
    seleccionar = false;
    super.initState();
  }

  @override
  void dispose() {
    seleccionar = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final estiloTexto = TextStyle(fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text("Personas y Bonos"),
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, "inputPersonas");
              //Navigator.pushReplacementNamed(context, "inputPersonas");
            },
          ),
          IconButton(
            icon: Icon(Icons.border_right_outlined),
            onPressed: () {
              Navigator.pushNamed(context, "inputBonos");

              //Navigator.pushReplacementNamed(context, "inputBonos");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green.withOpacity(0.2),
              height: size.height * 0.409,
              child: Column(
                children: [
                  ListTile(
                    title: Text("PERSONAS"),
                    tileColor: Colors.green,
                  ),
                  Expanded(
                      child: FutureBuilder(
                          future: personasProvider.getPersonas(),
                          builder:
                              (context, AsyncSnapshot<List<Persona>> snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: snapshot.data
                                      .map((persona) => GestureDetector(
                                            onTap: () {
                                              print("ID Persona: " +
                                                  persona.idPersona);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Cancelar"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("OK"),
                                                        onPressed: () {
                                                          idPersonaSelecciona =
                                                              "";
                                                          seleccionar = true;
                                                          idPersonaSelecciona =
                                                              persona.idPersona;

                                                          Navigator.pop(
                                                              context);
                                                          print(
                                                              idPersonaSelecciona);
                                                        },
                                                      )
                                                    ],
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    content: Builder(
                                                      builder: (context) {
                                                        var height =
                                                            size.height * 0.1;
                                                        // var width =
                                                        //     size.width * 0.4;
                                                        return Container(
                                                          height: height,
                                                          child: Column(
                                                            children: [
                                                              Text("ID: " +
                                                                  persona
                                                                      .idPersona),
                                                              Center(
                                                                  child: Text(
                                                                "Seleccionar un bono para asignar a esta persona",
                                                                style:
                                                                    estiloTexto,
                                                              )),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons
                                                          .delete_forever_outlined),
                                                      onPressed: () {
                                                        print(
                                                            persona.idPersona);
                                                        setState(() {});

                                                        setState(() {
                                                          personasProvider
                                                              .eliminarPersona(
                                                                  persona
                                                                      .idPersona);
                                                        });

                                                        personasProvider
                                                            .eliminarPersona(
                                                                persona
                                                                    .idPersona);

                                                        setState(() {});
                                                      },
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "Nombre: " +
                                                                persona.nombre,
                                                            style: estiloTexto),
                                                        Text(
                                                            "Apellido: " +
                                                                persona
                                                                    .apellido,
                                                            style: estiloTexto),
                                                        SizedBox(height: 20),
                                                        Text(
                                                            "Bono: " +
                                                                persona
                                                                    .totalBono,
                                                            style: estiloTexto),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                                Divider(thickness: 5),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              );
                            } else {
                              print("sin data aún");
                            }
                            return Container(); //venir aquí
                          })),
                ],
              ),
            ),
            Container(
              color: Colors.blue.withOpacity(0.2),
              height: size.height * 0.5,
              child: Column(
                children: [
                  ListTile(
                    title: Text("BONOS"),
                    tileColor: Colors.blue,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: bonosProvider.getBonos(),
                      builder: (context, AsyncSnapshot<List<Bono>> snapshot) {
                        if (snapshot.hasData) {
                          // print("DATA" + snapshot.data.toString());
                          return SingleChildScrollView(
                            child: Column(
                              children: snapshot.data
                                  .map((bono) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            print("ID: " + bono.idBono);
                                            if (seleccionar == true) {
                                              bonoSeleccionado = bono.totalBono;
                                              print(bonoSeleccionado);
                                              if (bonoSeleccionado != null) {
                                                print("Bono:" + bono.idBono);
                                                personasProvider
                                                    .anadirBonoPersona(
                                                  idPersonaSelecciona,
                                                  bonoSeleccionado,
                                                );
                                                seleccionar = false;
                                                print(seleccionar);
                                              }
                                            }
                                            personasProvider.getPersonas();
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .delete_forever_outlined),
                                                  onPressed: () {
                                                    setState(() {});

                                                    setState(() {
                                                      print(bono.idBono);
                                                      bonosProvider
                                                          .eliminarBono(
                                                              bono.idBono);
                                                    });

                                                    setState(() {});
                                                  },
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Valor por día: " +
                                                            bono.valor
                                                                .toString(),
                                                        style: estiloTexto),
                                                    Text(
                                                        "Fecha Inicio: " +
                                                            bono.fechaInicio,
                                                        style: estiloTexto),
                                                    Text(
                                                        "Fecha Fin: " +
                                                            bono.fechaFin,
                                                        style: estiloTexto),
                                                    Text(
                                                        "Total Bono: " +
                                                            bono.totalBono,
                                                        style: estiloTexto),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            Divider(thickness: 5),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        } else {
                          print("No tiene data");
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
