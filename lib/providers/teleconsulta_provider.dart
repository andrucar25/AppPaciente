import 'dart:io';

import 'package:applaluz/models/ArchivoTeleconsulta.dart';
import 'package:applaluz/models/Teleconsulta.dart';
import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applaluz/utils/config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class TeleconsultaProvider {
  Future<List<Teleconsulta>> getTeleconsultaPendiente() async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };

    final url =
        Uri.https(urlApi, '$versionApi/teleconsulta/pendingTeleconsultation');

    if (prefs.token != '') {
      final resp = await http.get(url, headers: requestHeaders);
      final decodedData = json.decode(resp.body);
      final teleconsultasPendientes =
          new Teleconsultas.fromJsonList(decodedData);
      return teleconsultasPendientes.items;
    } else {
      return [];
    }
  }

  Future<List<Teleconsulta>> getTeleconsultaHistorial() async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };

    final url =
        Uri.https(urlApi, '$versionApi/teleconsulta/historyTeleconsultation');

    if (prefs.token != '') {
      final resp = await http.get(url, headers: requestHeaders);
      final decodedData = json.decode(resp.body);
      final teleconsultasHistorial =
          new Teleconsultas.fromJsonList(decodedData);
      return teleconsultasHistorial.items;
    } else {
      return [];
    }
  }

  Future<List<ArchivoTeleconsulta>> getArchivosTeleconsulta(
      int idTeleconsulta) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };

    final url = Uri.https(urlApi, '$versionApi/archivoTeleconsulta',
        {'id': idTeleconsulta.toString()});

    final resp = await http.get(url, headers: requestHeaders);
    print(resp.body);
    final decodedData = json.decode(resp.body);
    final archivosTeleconsulta =
        new ArchivoTeleconsultas.fromJsonList(decodedData);

    return archivosTeleconsulta.items;
  }

  Future<String> uploadFile(
      int idTeleconsulta, File fileData, int idMedico) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    Map<String, String> body = {
      "idMedico": idMedico.toString(),
      "idTeleconsulta": idTeleconsulta.toString(),
    };

    final url = Uri.https(urlApi, '$versionApi/archivoTeleconsulta');

    final mimeType = mime(fileData.path).split('/');

    final fileUploadRequest = http.MultipartRequest('POST', url);
    fileUploadRequest.headers.addAll(requestHeaders);
    fileUploadRequest.fields.addAll(body);
    final file = await http.MultipartFile.fromPath('archivo', fileData.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    fileUploadRequest.files.add(file);

    final streamResponse = await fileUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return 'success';
  }

  Future<String> storeTeleconsulta(int idMedico, String fechaHora) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "idMedico": idMedico,
      "fechaHora": fechaHora,
    });

    final url =
        Uri.https(urlApi, '$versionApi/teleconsulta/storeTeleconsultation');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(resp.body);
    return (decodedResp['status'] == "register_ok")
        ? "Teleconsulta guardada"
        : decodedResp['message'];
  }
}
