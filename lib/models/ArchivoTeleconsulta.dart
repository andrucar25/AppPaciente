import 'package:applaluz/models/Teleconsulta.dart';

class ArchivoTeleconsultas {
  List<ArchivoTeleconsulta> items = [];
  ArchivoTeleconsulta item = new ArchivoTeleconsulta();

  ArchivoTeleconsultas();

  ArchivoTeleconsultas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final archivoTeleconsulta = new ArchivoTeleconsulta.fromJsonMap(item);
      items.add(archivoTeleconsulta);
    }
  }
  ArchivoTeleconsultas.fromJsonObjectData(dynamic jsonObjectData) {
    if (jsonObjectData == null) return;

    final archivoTeleconsulta =
        new ArchivoTeleconsulta.fromJsonMap(jsonObjectData);
    item = archivoTeleconsulta;
  }
}

class ArchivoTeleconsulta {
  int idArchivoTeleconsulta;
  Teleconsulta teleconsulta;
  String archivo;

  ArchivoTeleconsulta({
    this.idArchivoTeleconsulta,
    this.teleconsulta,
    this.archivo,
  });

  ArchivoTeleconsulta.fromJsonMap(Map<String, dynamic> json) {
    dynamic teleconsultaData = json['teleconsulta'];
    final teleconsultaObject =
        new Teleconsultas.fromJsonObjectData(teleconsultaData);
    idArchivoTeleconsulta = json['idArchivoTeleconsulta'];
    archivo = json['archivo'];

    teleconsulta = teleconsultaObject.item;
  }
}
