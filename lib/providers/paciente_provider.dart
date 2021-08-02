import 'package:applaluz/models/Paciente.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applaluz/utils/config.dart';
import 'package:applaluz/user_preferences/user_preferences.dart';

class PacienteProvider {
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {'email': email, 'password': password};
    final url = Uri.https(urlApi, '$versionApi/auth/pacientes');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp['token']);
    if (decodedResp.containsKey('token')) {
      _prefs.token = decodedResp['token'];
      return {'ok': true, 'token': decodedResp['token']};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  Future<Paciente> getPacienteData() async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final url = Uri.https(urlApi, '$versionApi/utils/pacientes');
    final resp = await http.get(url, headers: requestHeaders);
    final decodedData = json.decode(resp.body);

    final paciente = new Paciente.fromJsonMap(decodedData);

    return paciente;
  }

  Future<bool> logout() async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    try {
      final url = Uri.https(urlApi, '$versionApi/auth/pacientes/logout');
      final resp = await http.post(url, headers: requestHeaders);
      final decodedData = json.decode(resp.body);
      print(decodedData);
      prefs.token = '';
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changuePassword(String currentPass, String newPass) async {
    final newPassData = {
      'current_password': currentPass,
      'new_password': newPass
    };
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    try {
      final url =
          Uri.https(urlApi, '$versionApi/auth/pacientes/change-password');
      final resp = await http.post(url,
          body: json.encode(newPassData), headers: requestHeaders);
      final decodedData = json.decode(resp.body);
      print(decodedData);
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      print(decodedResp['status'] == 'failed');
      if (decodedResp['status'] == 'failed') {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String dni, String nombres, String apellidos,
      String email, String telefono, String foto, String clave) async {
    final newPacienteData = {
      'dni': dni,
      'nombres': nombres,
      'apellidos': apellidos,
      'email': email,
      'telefono': telefono,
      'foto': foto,
      'clave': clave
    };
    final prefs = new UserPreferences();
    final url = Uri.https(urlApi, '$versionApi/auth/pacientes/register');

    final resp = await http.post(url,
        body: json.encode(newPacienteData),
        headers: {"Content-Type": "application/json"});

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (!decodedResp.containsKey('token')) {
      return false;
    } else {
      prefs.token = decodedResp['token'];
      return true;
    }
  }
}
