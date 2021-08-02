/*

* Screen para recuperar la contraseña

* 

* @author Sigfredo Aponte Roldan

* @version 1.0 

*/ 
import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olvide mi contraseña"),
      ),
      body: Body(),
    );
  }
}
