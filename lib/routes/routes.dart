import 'package:applaluz/screens/chat_screen/chat_screen.dart';
import 'package:applaluz/screens/chat_screen/loading_screen.dart';
import 'package:applaluz/screens/chat_screen/login_screen.dart';
import 'package:applaluz/screens/chat_screen/register_screen.dart';
import 'package:applaluz/screens/chat_screen/user_screen.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'user': (_) => UserScreen(),
  'chat': (_) => ChatScreen(),
  'login': (_) => LoginScreen(),
  'register': (_) => RegisterScreen(),
  'loading': (_) => LoadingScreen(),
};
