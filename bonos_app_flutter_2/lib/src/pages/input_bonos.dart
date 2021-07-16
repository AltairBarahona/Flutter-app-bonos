import 'package:bonos_app_flutter_2/src/providers/bonos_provider.dart';
import 'package:flutter/material.dart';

class InputBonosPage extends StatefulWidget {
  @override
  _InputBonosPageState createState() => _InputBonosPageState();
}

class _InputBonosPageState extends State<InputBonosPage> {
  String fechaInicio = "";
  String fechaFin = "";
  String valor = "";
  double totalBono = 0.0;

  TextEditingController inputFechaInicio = new TextEditingController();
  TextEditingController inputFechaFin = new TextEditingController();

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
          title: Text("CREAR BONO"),
          leading: Container(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _InputValor(),
              _InputFechaInicio(),
              _InputFechaFin(),
              TextButton(
                child: Text(
                  "Crear",
                  style: estiloTexto,
                ),
                onPressed: () {
                  print("======INICIO======");

                  var inicioTemp = fechaInicio.toString().substring(5, 10);
                  print(inicioTemp);

                  var inicioMes = inicioTemp.toString().substring(0, 2);
                  var inicioMesDouble = double.parse(inicioMes);
                  print("Inicio Mes string: " + inicioMes);
                  print("Inicio Mes double: " + inicioMesDouble.toString());

                  var inicioDia = inicioTemp.toString().substring(3, 5);
                  var inicioDiaDouble = double.parse(inicioDia);
                  print("Inicio Dia string: " + inicioDia);
                  print("Inicio Dia double: " + inicioDiaDouble.toString());

                  print("======FIN======");
                  var finTemp = fechaFin.toString().substring(5, 10);
                  print(finTemp);

                  var finMes = finTemp.toString().substring(0, 2);
                  var finMesDouble = double.parse(finMes);
                  print("Fin Mes string: " + finMes);
                  print("Fin Mes double: " + finMesDouble.toString());

                  var finDia = finTemp.toString().substring(3, 5);
                  var finDiaDouble = double.parse(finDia);
                  print("Fin Dia string: " + finDia);
                  print("Fin Dia double: " + finDiaDouble.toString());

                  var valorTemp = double.parse(valor);
                  var totalDias = (inicioDiaDouble - finDiaDouble);
                  if (totalDias < 0) {
                    totalDias = totalDias * -1;
                  }
                  totalBono = valorTemp * totalDias;

                  print(totalDias);
                  print("Bono: " + totalBono.toString());
                  setState(() {
                    bonosProvider.agregarBono(
                      valor,
                      fechaInicio,
                      fechaFin,
                      totalBono.toString(),
                    );

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
                                "Bono creado con éxito",
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

  Padding _InputValor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: estiloTexto,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: "Valor del Bono",
          labelText: "Valor del Bono",
        ),
        onChanged: (value) {
          valor = value;
        },
      ),
    );
  }

  Padding _InputFechaInicio() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: inputFechaInicio,
        style: estiloTexto,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.calendar_today_outlined),
          hintText: "Fecha de inicio bonos",
          labelText: "Fecha de inicio bonos",
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateInicio(context);
        },
      ),
    );
  }

  Padding _InputFechaFin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: inputFechaFin,
        style: estiloTexto,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.calendar_today_outlined),
          hintText: "Fecha de fin bonos",
          labelText: "Fecha de fin bonos",
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateFin(context);
        },
      ),
    );
  }

  _selectDateInicio(BuildContext context) async {
    DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2022),
    );

    if (datePicked != null) {
      setState(() {
        fechaInicio = datePicked.toString().substring(0, 10);
        inputFechaInicio.text = fechaInicio;
        print(fechaInicio.toString());
        print(inputFechaInicio.text);
      });
    }
  }

  _selectDateFin(BuildContext context) async {
    DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2022),
    );

    if (datePicked != null) {
      setState(() {
        fechaFin = datePicked.toString().substring(0, 10);
        inputFechaFin.text = fechaFin;
        print(fechaFin.toString());
        print(inputFechaFin.text);
      });
    }
  }
}
