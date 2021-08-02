import 'package:flutter/material.dart';

import 'components/body.dart';

class LaboratoryTicketScreen extends StatefulWidget {
  static String routeName = "/laboratory_ticket_screen";
  @override
  _LaboratoryScreenState createState() => _LaboratoryScreenState();
}

class _LaboratoryScreenState extends State<LaboratoryTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LaboratoryTicketBody(),
    );
  }
}
