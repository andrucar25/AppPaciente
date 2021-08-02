import 'package:applaluz/models/user.dart';
import 'package:applaluz/models/users_response.dart';
import 'package:applaluz/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:applaluz/global/environment.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Environment.apiUrl}/usuarios', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
