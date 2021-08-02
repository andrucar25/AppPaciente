/*

* Screen para formulario de pagos

* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 
import 'package:applaluz/models/Medico.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class PaymentScreenChat extends StatefulWidget {
  static String routeName = "/payment_screen_chat";

  @override
  _PaymentScreenChatState createState() => _PaymentScreenChatState();
}

class _PaymentScreenChatState extends State<PaymentScreenChat> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PaymentFormChat(),
    );
  }
}
