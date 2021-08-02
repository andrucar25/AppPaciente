import 'package:applaluz/models/Medico.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class SuggestionScreen extends StatefulWidget {
  static String routeName = "/suggestion_screen";
  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SuggestionForm(),
    );
  }
}
