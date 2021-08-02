import 'package:applaluz/models/Laboratorio.dart';
import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applaluz/utils/config.dart';

class LaboratorioProvider {
  Future<List<Laboratorio>> getLaboratorio() async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };

    final url = Uri.https(urlApi, '$versionApi/laboratorio/labHistory');

    if (prefs.token != '') {
      final resp = await http.get(url, headers: requestHeaders);
      final decodedData = json.decode(resp.body);
      final laboratorios = new Laboratorios.fromJsonList(decodedData);
      return laboratorios.items;
    }else {
      return [];
    }
  }
}


