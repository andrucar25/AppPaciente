/*

* Screen para listar las teleconsultas pendientes

* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 

import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:applaluz/theme.dart';



class PendingTeleconsultationScreen extends StatelessWidget {
  static String routeName = "/pending_teleconsultation_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TeleconsultaPendiente(),
    );
  }
}
