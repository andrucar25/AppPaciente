class Laboratorios {
  List<Laboratorio> items = [];
  Laboratorio item = new Laboratorio();

  Laboratorios();

  Laboratorios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final laboratorio = new Laboratorio.fromJsonMap(item);
      items.add(laboratorio);
    }
  }
  Laboratorios.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final laboratorio = new Laboratorio.fromJsonMap(jsonObjectData);
    item = laboratorio;
  }
}

class Laboratorio {
  int idLaboratorio;
  int idPaciente;
  String descripcion;
  String fecha;
  String responsable;
  String area;
  String archivo;

  Laboratorio({
    this.idLaboratorio,
    this.idPaciente,
    this.descripcion,
    this.fecha,
    this.responsable,
    this.area,
    this.archivo,
  });

  Laboratorio.fromJsonMap(Map<String, dynamic> json) {
    idLaboratorio = json['idLaboratorio'];
    idPaciente = json['idPaciente'];
    descripcion = json['descripcion'];
    fecha = json['fecha'];
    responsable = json['responsable'];
    area = json['area'];
    archivo = json['archivo'];
  }
}
