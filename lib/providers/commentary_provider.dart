import 'package:applaluz/models/Comentario.dart';
import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:applaluz/utils/config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class CommentaryProvider {
  Future<String> storeCommentary(
      double puntuacion, String descripcion, int idMedico) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "puntuacion": puntuacion,
      "descripcion": descripcion,
      "idMedico": idMedico,
    });

    final url = Uri.https(urlApi, '$versionApi/comentario/storeCommentary');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return (decodedResp['status'] == "register_ok")
        ? "Comentario guardado"
        : decodedResp['message'];
  }

  Future<List<Comentario>> getCommentaryMedic(int idMedico) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final url = Uri.https(
        urlApi, '$versionApi/comentario', {'idMedico': idMedico.toString()});

    final resp = await http.get(url, headers: requestHeaders);
    //print(resp.body);
    final decodedData = json.decode(resp.body);
    final comentariosMedico = new Comentarios.fromJsonList(decodedData);

    return comentariosMedico.items;
  }
}
