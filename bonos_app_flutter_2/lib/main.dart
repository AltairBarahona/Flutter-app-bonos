import 'package:flutter/material.dart';
import 'package:bonos_app_flutter_2/src/pages/home_page.dart';
import 'package:bonos_app_flutter_2/src/pages/input_bonos.dart';
import 'package:bonos_app_flutter_2/src/pages/input_personas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp',
      initialRoute: "homePage",
      routes: {
        "homePage": (context) => HomePage(),
        "inputPersonas": (context) => InputPersonasPage(),
        "inputBonos": (context) => InputBonosPage(),
      },
    );
  }
}
