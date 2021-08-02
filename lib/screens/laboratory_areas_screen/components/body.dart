import 'package:applaluz/helper/areas.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'item_list.dart';

class AreasMenu extends StatefulWidget {
  @override
  _AreasMenuState createState() => _AreasMenuState();
}

class _AreasMenuState extends State<AreasMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text('AREAS DE',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: kTextColor,
                        letterSpacing: 12.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300)),
                Text(
                  'LABORATORIO',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: kPrimaryColor,
                      letterSpacing: 12.0,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          //backgroundColor: kPrimaryColor,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(10),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30)),
          child: GridView.count(
            crossAxisCount: 2,
            children: areasLista(),
          ),
        ),
      ),
    );
  }

  List<Widget> areasLista() {
    List<Widget> lista = [];

    Areas.areasList.forEach((area) {
      lista.add(
          AreaItem(title: area.title, route: area.imagePath, area: area.area));
    });
    return lista;
  }
}
