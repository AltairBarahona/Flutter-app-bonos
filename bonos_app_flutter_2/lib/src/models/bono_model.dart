class Bonos {
  List<Bono> listaBonos = [];
  Bonos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    jsonList.forEach((bono) {
      final bonoTemp = Bono.fromJsonMap(bono);
      listaBonos.add(bonoTemp);
    });
  }
}

class Bono {
  String idBono;
  String valor;
  String fechaInicio;
  String fechaFin;
  String totalBono;

  Bono(
    this.idBono,
    this.valor,
    this.fechaInicio,
    this.fechaFin,
    this.totalBono,
  );

  Bono.fromJsonMap(Map<String, dynamic> json) {
    idBono = json["id"];
    valor = json["valor"];
    fechaInicio = json["fechaInicio"];
    fechaFin = json["fechaFin"];
    totalBono = json["totalBono"];
  }
}
