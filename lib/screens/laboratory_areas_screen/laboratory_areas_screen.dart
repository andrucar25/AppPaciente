import 'package:flutter/material.dart';

import 'components/body.dart';

class LaboratoryAreasScreen extends StatefulWidget {
  @override
  _LaboratoryAreasScreenState createState() => _LaboratoryAreasScreenState();
}

class _LaboratoryAreasScreenState extends State<LaboratoryAreasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AreasMenu(),
    );
  }
}
