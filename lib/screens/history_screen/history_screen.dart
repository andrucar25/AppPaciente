/*

* Screen para listar las categorias de los historiales
* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 
import 'package:flutter/material.dart';
import 'components/card_Teleconsulta.dart';
import 'components/card_Laboratorio.dart';
import 'package:applaluz/theme.dart';
import '../../size_config.dart';
import 'package:applaluz/constants.dart';

class HistoryScreen extends StatefulWidget {
  static String routeName = "/history_screen";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('CATEGORIAS DE',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kTextColor,
                    letterSpacing: 12.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300)),
            Text(
              'HISTORIALES',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: kPrimaryColor,
                  letterSpacing: 12.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        //backgroundColor: kPrimaryColor,
      ),
             body: Container(
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(50),
              left: getProportionateScreenWidth(10),
              right: getProportionateScreenWidth(10)),
          child: ListView(
            children: <Widget>[
              StaggeredCardCard(),
              Padding(padding: EdgeInsets.only(
              top: getProportionateScreenWidth(50),
              left: getProportionateScreenWidth(10),
              right: getProportionateScreenWidth(10)),
              ),
              StaggeredCardLab(),
            ],
          ),
        ),
    //  body:  StaggeredCardCard(),
    
    );
  }
}
