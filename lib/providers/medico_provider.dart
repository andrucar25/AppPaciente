import 'package:applaluz/models/HorarioMedico.dart';
import 'package:applaluz/models/Medico.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applaluz/utils/config.dart';

class MedicoProvider {
  Future<List<Medico>> getMedicos() async {
    final url = Uri.https(urlApi, '$versionApi/medico');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final medicos = new Medicos.fromJsonList(decodedData);

    return medicos.items;
  }

  Future<List<HorarioMedico>> getHorarioMedicos(int mes, int idMedico) async {
    final sendData = {'idMedico': idMedico.toString(), 'mes': mes.toString()};
    final url =
        Uri.https(urlApi, '$versionApi/horarioMedico/getDates', sendData);
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final medicos = new HorarioMedicos.fromJsonList(decodedData);
    return medicos.items;
  }
}
