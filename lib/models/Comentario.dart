import 'Paciente.dart';

class Comentarios {
  List<Comentario> items = [];
  Comentario item = new Comentario();

  Comentarios();

  Comentarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final comentario = new Comentario.fromJsonMap(item);
      items.add(comentario);
    }
  }
  Comentarios.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final comentario = new Comentario.fromJsonMap(jsonObjectData);
    item = comentario;
  }
}

class Comentario {
  int idComentario;
  int idMedico;
  Paciente paciente;
  int puntuacion;
  String estado;
  String descripcion;
  String fecha;

  Comentario({
    this.idComentario,
    this.idMedico,
    this.paciente,
    this.puntuacion,
    this.estado,
    this.descripcion,
    this.fecha,
  });

  Comentario.fromJsonMap(Map<String, dynamic> json) {
    dynamic pacienteData = json['paciente'];
    final pacienteObject =
        new Pacientes.fromJsonObjectData(pacienteData);
    idComentario = json['idComentario'];
    idMedico = json['idMedico'];
    paciente = pacienteObject.item;
    puntuacion = json['puntuacion'];
    estado = json['estado'];
    descripcion = json['descripcion'];
    fecha = json['fecha'];

  }
}
