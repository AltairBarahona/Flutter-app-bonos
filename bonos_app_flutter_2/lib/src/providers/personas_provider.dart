import 'dart:convert';
import 'package:bonos_app_flutter_2/src/models/persona_model.dart';
import 'package:http/http.dart' as http;

class PersonasProvider {
  String _url = "http://10.0.2.2:8080/api";
  List<Persona> listaPersonas = [];

  PersonasProvider() {
    getPersonas();
  }
  Future<List<Persona>> getPersonas() async {
    var response = await http.get(
      Uri.parse(_url + "/personas"),
      headers: {"Accept": "application/json"},
    );
    try {
      var decodedData = json.decode(response.body);

      var personasACrear = Personas.fromJsonList(decodedData);
      return personasACrear.listaPersonas;
    } catch (e) {
      return [];
    }
  }

  Future<http.Response> agregarPersona(String nombre, apellido) async {
    return await http.post(
      Uri.parse(_url + "/persona"),
      // headers: {"Accept": "application/json"},
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode(
        <String, String>{
          // 'idPersona': idPersona,
          'nombre': nombre,
          'apellido': apellido,
        },
      ),
    );
  }

  Future<http.Response> anadirBonoPersona(String id, String totalBono) async {
    return await http.put(
      Uri.parse(_url + "/persona/$id"),
      // headers: {"Accept": "application/json"},
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode(
        <String, String>{
          // 'idPersona': idPersona,
          'totalBono': totalBono,
        },
      ),
    );
  }

  Future<http.Response> eliminarPersona(var id) async {
    return await http.delete(
      Uri.parse(_url + "/persona/$id"),
    );
  }

  // Future<List<Persona>> filtrarPersonas(int caballos, int deposito) async {
  //   var response = await http.get(
  //     Uri.parse(_url + "/persona/filtrar/$caballos/$deposito"),
  //     headers: {"Accept": "application/json"},
  //   );
  //   try {
  //     var decodedData = json.decode(response.body);
  //     var PersonasACrear = Personas.fromJsonList(decodedData);
  //     print("Entra acá4");
  //     print("Personas:" + PersonasACrear.listaPersonas.toString());
  //     return PersonasACrear.listaPersonas;
  //   } catch (e) {
  //     print("Entra acá1");
  //     return [];
  //   }
  // }

}

final personasProvider = PersonasProvider();
