import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applaluz/utils/config.dart';

class ChatProvider {
  Future<String> getChatMedico() async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };

    final url = Uri.https(urlApi, '$versionApi/chatMedico/searchChatPaciente');
    final resp = await http.get(url, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return (decodedResp['status'] == "Existe") ? "Existe" : "Vacio";

/*
    if(resp.body.isNotEmpty){
      print("Existe");
      print(resp.body);
      return "Existe"; 
    }else{
         print("Vacio");
         print(resp.body);
      return "Vacio";
    }*/
  }

  Future<String> storeChatMedico(int id) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "idMedico": id,
    });

    final url = Uri.https(urlApi, '$versionApi/chatMedico/storeChatPaciente');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(resp.body);
    return (decodedResp['status'] == "register_ok")
        ? "Chat Guardado"
        : decodedResp['message'];
  }
}
