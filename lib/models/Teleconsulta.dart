class Teleconsultas {
  List<Teleconsulta> items = [];
  Teleconsulta item = new Teleconsulta();

  Teleconsultas();

  Teleconsultas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final teleconsulta = new Teleconsulta.fromJsonMap(item);
      items.add(teleconsulta);
    }
  }
  Teleconsultas.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final teleconsulta = new Teleconsulta.fromJsonMap(jsonObjectData);
    item = teleconsulta;
  }
}

class Teleconsulta {
  int idTeleconsulta;
  int idPaciente;
  int idMedico;
  String diagnostico;
  String receta;
  String estadoConsulta;
  String estadoPago;
  String fecha;
  String hora;
  String enlace;
  String especialidad;
  String foto;
  String nombresMedico;
  String apellidosMedico;

  Teleconsulta({
    this.idTeleconsulta,
    this.idPaciente,
    this.idMedico,
    this.diagnostico,
    this.receta,
    this.estadoConsulta,
    this.estadoPago,
    this.fecha,
    this.hora,
    this.enlace,
    this.especialidad,
    this.foto,
    this.nombresMedico,
    this.apellidosMedico,
  });

  Teleconsulta.fromJsonMap(Map<String, dynamic> json) {
    idTeleconsulta = json['idTeleconsulta'];
    idPaciente = json['idPaciente'];
    idMedico = json['idMedico'];
    diagnostico = json['diagnostico'];
    receta = json['receta'];
    estadoConsulta = json['estadoConsulta'];
    estadoPago = json['estadoPago'];
    fecha = json['fecha'];
    hora = json['hora'];
    enlace = json['enlace'];
    especialidad = json['especialidad'];
    foto = json['foto'];
    nombresMedico = json['nombresMedico'];
    apellidosMedico = json['apellidosMedico'];
  }
}
