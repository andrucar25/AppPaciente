class Reclamos {
  List<Reclamo> items = [];
  Reclamo item = new Reclamo();

  Reclamos();

  Reclamos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final reclamo = new Reclamo.fromJsonMap(item);
      items.add(reclamo);
    }
  }
  Reclamos.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final reclamo = new Reclamo.fromJsonMap(jsonObjectData);
    item = reclamo;
  }
}

class Reclamo {
  int idReclamo;
  int tipo;
  String descripcion;
  int idPaciente;
  String fecha;
  int estado;
  String archivo;

  Reclamo({
    this.idReclamo,
    this.tipo,
    this.descripcion,
    this.idPaciente,
    this.fecha,
    this.estado,
    this.archivo,
  });

  Reclamo.fromJsonMap(Map<String, dynamic> json) {
    idReclamo = json['idReclamo'];
    tipo = json['tipo'];
    descripcion = json['descripcion'];
    idPaciente = json['idPaciente'];
    fecha = json['fecha'];
    estado = json['estado'];
    archivo = json['archivo'];
  }
}
