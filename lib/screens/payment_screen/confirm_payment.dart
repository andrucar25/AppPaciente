/*

* Screen para la card de pagos cuando el usuario agenda una teleconsulta exitosamente

* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 
import 'package:applaluz/models/Medico.dart';
import 'package:flutter/material.dart';
import 'package:applaluz/theme.dart';
import 'package:applaluz/screens/payment_screen/components/card_payment.dart';
import '../../constants.dart';

void main() => runApp(ConfirmPayment());

class ConfirmPayment extends StatefulWidget {
  static String routeName = "/confirm_payment";
  ConfirmPayment({this.fechaHora, this.medico});

  final String fechaHora;
  final Medico medico;

  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _fondo(),
        CardPayment(
          fechaHora: widget.fechaHora,
          medico: widget.medico,
        )
        //CardSend()
      ],
    ));
  }

  Widget _fondo() {
    final fondo = Container(
      color: Color.fromRGBO(255, 255, 255, 1.0),
      width: double.infinity,
      height: double.infinity,
    );

    return Stack(
      children: <Widget>[
        fondo,
        Positioned(
          left: -70.0,
          top: -85.0,
          child: Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: kPrimaryColor),
          ),
        ),
        Positioned(
          right: -25.0,
          top: -48.0,
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
