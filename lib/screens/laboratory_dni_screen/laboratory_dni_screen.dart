import 'package:flutter/material.dart';

import 'components/body.dart';

class DNILaboratoryScreen extends StatefulWidget {
  static String routeName = "/dni_laboratory_screen";
  @override
  _ConfirmationLaboratoryScreenState createState() =>
      _ConfirmationLaboratoryScreenState();
}

class _ConfirmationLaboratoryScreenState extends State<DNILaboratoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DniLaboratoryBody(),
    );
  }
}
