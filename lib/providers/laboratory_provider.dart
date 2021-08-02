import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:applaluz/utils/config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LaboratoryProvider {
  Future<Map<String, dynamic>> storeLaboratory(
      String responsable, int area, String descripcion) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "area": area,
      "responsable": responsable,
      "descripcion": descripcion,
    });

    final url = Uri.https(urlApi, '$versionApi/laboratorio');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['status'] == "register_ok") {
      return {'ok': true, 'message': decodedResp['message']};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  Future<Map<String, dynamic>> sendConfirmation(String telefono) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "telefono": telefono,
    });

    final url = Uri.https(urlApi, '$versionApi/laboratorio/sendSMS');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if (decodedResp['status'] == "send") {
      return {'ok': true, 'number': decodedResp['number']};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  Future<String> getReniecData(String data) async {
    final url =
        Uri.https(urlApisPeru, '/api/v1/dni/$data', {'token': tokenApisPeru});

    String response = '';
    try {
      final resp = await http.get(url);
      Map<String, dynamic> decodedData = json.decode(resp.body);

      if (decodedData.containsKey('nombres'))
        response =
            '${decodedData['nombres']}, ${decodedData['apellidoPaterno']} ${decodedData['apellidoMaterno']} ';
    } catch (e) {
      print('Ocurrio un error');
    }

    return response;
  }
}
