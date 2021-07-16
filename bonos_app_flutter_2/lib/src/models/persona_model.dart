class Personas {
  List<Persona> listaPersonas = [];
  Personas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    jsonList.forEach((persona) {
      final personaTemp = Persona.fromJsonMap(persona);
      listaPersonas.add(personaTemp);
    });
  }
}

class Persona {
  String idPersona;
  String nombre;
  String apellido;
  String totalBono;

  Persona({
    this.idPersona,
    this.nombre,
    this.apellido,
    this.totalBono,
  });

  Persona.fromJsonMap(Map<String, dynamic> json) {
    idPersona = json["id"];
    nombre = json["nombre"];
    apellido = json["apellido"];
    totalBono = json["totalBono"];
    if (totalBono == null) {
      totalBono = "0";
    } else {
      totalBono = json["totalBono"];
    }
  }
}
