import 'package:flutter/material.dart';

import 'components/body.dart';

class LaboratoryScreen extends StatefulWidget {
  static String routeName = "/laboratory_screen";
  @override
  _LaboratoryScreenState createState() => _LaboratoryScreenState();
}

class _LaboratoryScreenState extends State<LaboratoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LaboratoryBody(),
    );
  }
}
