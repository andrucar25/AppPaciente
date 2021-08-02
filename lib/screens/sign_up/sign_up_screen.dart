/*

* Screen para registrar al usuario
* 

* @author Sigfredo Aponte Roldan

* @version 1.0 

*/ 

import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrarse"),
      ),
      body: Body(),
    );
  }
}
