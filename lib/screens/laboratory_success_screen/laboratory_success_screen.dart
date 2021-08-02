import 'package:flutter/material.dart';

import 'components/body.dart';

class LaboratorySuccessScreen extends StatefulWidget {
  static String routeName = "/laboratory_success_screen";
  @override
  _LaboratoryScreenState createState() => _LaboratoryScreenState();
}

class _LaboratoryScreenState extends State<LaboratorySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LaboratorySuccessBody(),
    );
  }
}
