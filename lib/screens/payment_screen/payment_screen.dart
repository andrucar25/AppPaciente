/*

* Screen para formulario de pagos

* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 
import 'package:applaluz/models/Medico.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment_screen";
  PaymentScreen({this.fechaHora, this.medico});

  final String fechaHora;
  final Medico medico;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PaymentForm(medico: widget.medico, fechaHora: widget.fechaHora,),
    );
  }
}
