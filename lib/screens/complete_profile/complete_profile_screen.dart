/*

* Screen para completar datos del perfil de usuario

* 

* @author Sigfredo Aponte Roldan

* @version 1.0 

*/ 
import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: Body(),
    );
  }
}
