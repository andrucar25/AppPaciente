import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'https://chat-node-laluz.herokuapp.com/api'
      : 'https://chat-node-laluz.herokuapp.com/api';
  static String socketUrl = Platform.isAndroid
      ? 'https://chat-node-laluz.herokuapp.com'
      : 'https://chat-node-laluz.herokuapp.com';
}
