import 'package:flutter/material.dart';

import 'components/body.dart';

class ConfirmationLaboratoryScreen extends StatefulWidget {
  static String routeName = "/confirmation_laboratory_screen";
  @override
  _ConfirmationLaboratoryScreenState createState() =>
      _ConfirmationLaboratoryScreenState();
}

class _ConfirmationLaboratoryScreenState
    extends State<ConfirmationLaboratoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConfirmationLaboratoryBody(),
    );
  }
}
