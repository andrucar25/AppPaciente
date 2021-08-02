class Medicos {
  List<Medico> items = [];
  Medico item = new Medico();

  Medicos();

  Medicos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final medico = new Medico.fromJsonMap(item);
      items.add(medico);
    }
  }
  Medicos.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final medico = new Medico.fromJsonMap(jsonObjectData);
    item = medico;
  }
}

class Medico {
  int idMedico;
  String nombres;
  String apellidos;
  String email;
  String cv;
  String foto;
  String estado;
  int idEspecialidad;

  Medico({
    this.idMedico,
    this.nombres,
    this.apellidos,
    this.email,
    this.cv,
    this.foto,
    this.estado,
    this.idEspecialidad,
  });

  Medico.fromJsonMap(Map<String, dynamic> json) {
    idMedico = json['idMedico'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    email = json['email'];
    cv = json['cv'];
    foto = json['foto'];
    estado = json['estado'];
    idEspecialidad = json['idEspecialidad'];
  }
}
