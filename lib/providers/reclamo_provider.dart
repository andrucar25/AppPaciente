import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:applaluz/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'dart:convert';

import 'package:mime_type/mime_type.dart';


class ReclamoProvider {

  Future<String> postReclamo(int tipo , String descripcion) async {
   final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({

      "tipo": tipo,

      "descripcion": descripcion,


    });
            final url = Uri.https(urlApi, '$versionApi/reclamo/storeSuggestion');
    final resp = await http.post(url, body:body, headers: requestHeaders);
     Map<String, dynamic> decodedResp = json.decode(resp.body);

  print(resp.body);
    return
    ( decodedResp['status'] == "register_ok" ) ?  "Registro exitoso" : decodedResp['message'] ;

  
  
  

  }

  Future<String> postReclamoArchivo(int tipo , String descripcion, File archivo) async {
   final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
          Map<String, String> body = {
      "tipo": tipo.toString(),
      "descripcion": descripcion,
    };
    final url = Uri.https(urlApi, '$versionApi/reclamo/storeSuggestion');
    final mimeType = mime(archivo.path).split('/');
    final fileUploadRequest = http.MultipartRequest('POST', url);
    fileUploadRequest.headers.addAll(requestHeaders);
    fileUploadRequest.fields.addAll(body);
    final file = await http.MultipartFile.fromPath('archivo', archivo.path,
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

  
   
  
}
