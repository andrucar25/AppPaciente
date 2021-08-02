/*

* Screen para listar las especialidades disponibles

* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 
import 'package:flutter/material.dart';
import 'components/body.dart';

class MedicMenuScreen extends StatelessWidget {
  static String routeName = "/medic_menu_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MedicMenu(),
    );
  }
}
