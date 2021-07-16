import 'dart:convert';
import 'package:bonos_app_flutter_2/src/models/bono_model.dart';
import 'package:http/http.dart' as http;

class BonosProvider {
  String _url = "http://10.0.2.2:8080/api";
  List<Bono> listaBonos = [];

  BonosProvider() {
    getBonos();
  }
  Future<List<Bono>> getBonos() async {
    var response = await http.get(
      Uri.parse(_url + "/bonos"),
      headers: {"Accept": "application/json"},
    );
    try {
      var decodedData = json.decode(response.body);

      var bonosACrear = Bonos.fromJsonList(decodedData);
      print("bonos:" + bonosACrear.listaBonos.toString());
      return bonosACrear.listaBonos;
    } catch (e) {
      print("Entro en error");
      return [];
    }
  }

  Future<http.Response> agregarBono(String valor, String fechaInicio,
      String fechaFin, String totalBono) async {
    return await http.post(
      Uri.parse(_url + "/bono"),
      // headers: {"Accept": "application/json"},
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode(
        <String, String>{
          // 'idBono': idBono,
          'valor': valor,
          'fechaInicio': fechaInicio,
          'fechaFin': fechaFin,
          'totalBono': totalBono.toString(),
        },
      ),
    );
  }

  Future<http.Response> eliminarBono(var id) async {
    return await http.delete(
      Uri.parse(_url + "/bono/$id"),
    );
  }

  // Future<List<Bono>> filtrarBonos(int caballos, int deposito) async {
  //   var response = await http.get(
  //     Uri.parse(_url + "/Bono/filtrar/$caballos/$deposito"),
  //     headers: {"Accept": "application/json"},
  //   );
  //   try {
  //     var decodedData = json.decode(response.body);
  //     var BonosACrear = Bonos.fromJsonList(decodedData);
  //     print("Entra acá4");
  //     print("Bonos:" + BonosACrear.listaBonos.toString());
  //     return BonosACrear.listaBonos;
  //   } catch (e) {
  //     print("Entra acá1");
  //     return [];
  //   }
  // }

}

final bonosProvider = BonosProvider();
