import 'package:applaluz/user_preferences/user_preferences.dart';
import 'package:applaluz/utils/config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class PaymentProvider {
  Future<String> postPayment(
      String token, String email, String description, double amount) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "token": token,
      "email": email,
      "description": description,
      "amount": amount,
    });

    final url = Uri.https(urlApi, '$versionApi/pagos');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    return (decodedResp['status'] == "success")
        ? "Venta exitosa"
        : decodedResp['message'];
  }

  Future<String> postPaymentChat(
      String token, String email, double amount) async {
    final prefs = new UserPreferences();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.token}'
    };
    final body = jsonEncode({
      "token": token,
      "email": email,
      "amount": amount,
    });

    final url = Uri.https(urlApi, '$versionApi/pagos/orderChargeChat');
    final resp = await http.post(url, body: body, headers: requestHeaders);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    return (decodedResp['status'] == "success")
        ? "Venta exitosa"
        : decodedResp['message'];
  }
}
