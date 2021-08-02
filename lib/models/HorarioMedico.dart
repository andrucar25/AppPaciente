import 'package:intl/intl.dart';

class HorarioMedicos {
  List<HorarioMedico> items = [];
  HorarioMedico item = new HorarioMedico();

  HorarioMedicos();

  HorarioMedicos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final medico = new HorarioMedico.fromJsonMap(item);
      items.add(medico);
    }
  }
  HorarioMedicos.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final medico = new HorarioMedico.fromJsonMap(jsonObjectData);
    item = medico;
  }
}

class Horas {
  List<String> items = [];
  String item = '';

  Horas();

  Horas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      items.add(item);
    }
  }
  Horas.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final medico = jsonObjectData.toString();
    item = medico;
  }
}

class HorarioMedico {
  int idHorarioMedico;
  DateTime dia;
  List<String> horasDisponibles;

  HorarioMedico({
    this.idHorarioMedico,
    this.dia,
    this.horasDisponibles,
  });

  HorarioMedico.fromJsonMap(Map<String, dynamic> json) {
    idHorarioMedico = json['idHorarioMedico'];
    dia = DateFormat('dd/MM/yyyy').parse(json['dia']);

    List<dynamic> horasData = json["horasDisponibles"];
    final horasList = new Horas.fromJsonList(horasData);

    horasDisponibles = horasList.items;
  }
}
