class Pacientes {
  List<Paciente> items = [];
  Paciente item = new Paciente();

  Pacientes();

  Pacientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final paciente = new Paciente.fromJsonMap(item);
      items.add(paciente);
    }
  }
  Pacientes.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final paciente = new Paciente.fromJsonMap(jsonObjectData);
    item = paciente;
  }
}

class Paciente {
  int idPaciente;
  String dni;
  String nombres;
  String apellidos;
  String email;
  String telefono;
  String estado;
  String foto;

  Paciente({
    this.idPaciente,
    this.dni,
    this.nombres,
    this.apellidos,
    this.email,
    this.telefono,
    this.estado,
    this.foto,
  });

  Paciente.fromJsonMap(Map<String, dynamic> json) {
    idPaciente = json['idPaciente'];
    dni = json['dni'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    email = json['email'];
    telefono = json['telefono'];
    estado = json['estado'];
    foto = json['foto'];
  }
}
